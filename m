Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ED6C9832A
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 02:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAery-00053X-0m; Sat, 26 Sep 2026 22:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAerw-000538-8h
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:44:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAeru-0007VX-Bp
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:43:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QMnmj01200140
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8NcmBAxi39EK2+wsdsFT9vJUAPDVjauXSLfke3uNBzk=; b=dC8CQ9sNp9NN0xOW
 P+Nrxrvj/E/P77XesNsvkah1u1R6IWlBLkHVGUBOXz2/CICKXf5wcoPty7j5YlaB
 1N0Z6F/LkTFFtxkb79WbXrhEDgAM6owW24iQfQPZ4/gCeSI122nwwpK7rkm7gSdc
 gm+wurlobkCthuK2+0v/e7vfERrSmJb58Um3EYwBiTnkIfuNxJ5Y0JYodWmW+bVo
 mldld61rpBh4dYKVvzFevtdBhc2dcmdRJiQKD5M5MT2bDztGWBK5yNt6zRkxLIMn
 AQp9iCuDK/w4JZWcaN5FJdjfYFoKdMK9Srs1uk/nWh1b6GNK8SyZjLom7E+5k58G
 xsQB/g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx64uta6m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:57 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-147be78cd56so2547489c88.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790477036; x=1791081836; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8NcmBAxi39EK2+wsdsFT9vJUAPDVjauXSLfke3uNBzk=;
 b=j1kvbVOSAhQdQytldsnVAa+DMIRqLjQLa92PZf7MVlyCxWGrN7jE4pl0/HL3mcCA8N
 6kpQE2jwQNGM5YLu687cQxau84zdfYhTnpJYDGpYdR61fpeNgPNUrLTWk2zkMaiTLiIU
 qLHzNBgjjRLrRHiskB0nZEME+GVWnsq7RISNFacS9cLWFgfPiI7PaXYPW1qStT4r1Qut
 +FCn9Zpk3C+kC88xM00wMtLnsPUY+axunIOqHBD/XeaK8wKReaGhkH+qavKFrez8sJa8
 1Uqkjx7voot8D/NuNOnPvHgA4suIsYs72Zq37zxZhD3ngmtj+FF2KRFcQH83qdupTG+A
 sWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790477036; x=1791081836;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8NcmBAxi39EK2+wsdsFT9vJUAPDVjauXSLfke3uNBzk=;
 b=PHZLBJKYEVGt+HA6/xXK/brJoiyl6erKbqB1B52jo4ieVtcz4ClOCBWWtSnI4UMpPe
 dwBVe3RGxyw5klgS0RLbKB77dvUvRykxmImw5i+RhS1Xb6FmfR08TcGWvs0XvvmW+1KG
 QNnZ8LAHaLqsAvFy6vzXKjCDjtQrjAq8Bfe3pR0yISnz2jpicdE5oxEMD8hu5HDlEC0H
 vqiWuTWXP26vQXtUaOyefAXKnWU35Xns9O5w4isR+oYCwBYvRmrz7WCSulhiDTNQCDl1
 4tVbK3Szxdg8TQvsbETlpOqBV8uTC/KbQFjBNYAV9M4aGLHlfHfF96B197sI3yuTzfOi
 w0cA==
X-Gm-Message-State: AFuF++mzcYcEYBL+ryl/2A/SHZ37eYwIUkdRtJAh53CoTvf4QvekNies
 Te97pUDSwSsspsUzItZxvvRJiQIKUPJsLTGayRBb+3q+iY2upXZMPKP9KlWAbzrkfky+5jzJyGY
 5GwibeW2ocSHgZtvBkaUQGJS3GzSDDzCKIHIUJVQs2s1v74GZ1sWevx4V5Ba91mc1uw==
X-Gm-Gg: AYBFou3UGdSDtK4peWqrYvZXwJVyhFi2E0GPAbNmLTe+JMbgZ7nXDBpO5KgaXhoRjUA
 YezGBm0yC4a0isWt8zubcoyRchnufp/2hUp6nUx9e0kQnLU0LWapJ1DgJkZj+gyJ4hMGej+OjxE
 DzRHCHntUVq829cTCKfxnYdiFpmuRjHty3GpsHN31PpB0nzkr3VuKrYbUs5bWU4Vsj1yZp+43rb
 JrFZbOX4u4xS+PTfczMuEOtfW4OPlouhbK1NTsBKgv4UhaEfdW3LM+dmkT+SjDcIHZ8H4rZKzRs
 22sMGEZyhFn0k+4jznIBqcqZUkz0AQ2ssdQYMqwN+GA6DTBSxzuo8ODzUc7frlO+g3Zxtz26Hz/
 MwWjQ/ZWaJ1T3U3jWGO/ZqdRCqEk3zJKDpsAUilq1TdQgaW8=
X-Received: by 2002:a05:7022:29b:b0:13c:ec65:7bca with SMTP id
 a92af1059eb24-146ce680830mr5661409c88.13.1790477036106; 
 Sat, 26 Sep 2026 19:43:56 -0700 (PDT)
X-Received: by 2002:a05:7022:29b:b0:13c:ec65:7bca with SMTP id
 a92af1059eb24-146ce680830mr5661355c88.13.1790477034939; 
 Sat, 26 Sep 2026 19:43:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ac67c3f8sm15459747c88.3.2026.09.26.19.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 19:43:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 4/5] target/hexagon: publish TLB updates before flushing
Date: Sat, 26 Sep 2026 19:43:46 -0700
Message-Id: <20260927024347.3545385-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
References: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX5IshTKMN1DZg
 4j6zqn3uA217qsxETUesSOc3OITarV+p0+qNFGkT8xSzRIyVn3OkKZyG8T1xuV+Reu2wjz+VKwq
 Tu/ZRx4ZKAR7UPKUJYRM4o7yY0n/URQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfXyv5VO2JbiCuB
 kErqY4F6X8VyUzXbXaVfboat86o4jo9fwxfDrlz/yZUgO50JHGJ8r93SSFoSq7PixdUSODA3/vd
 bCPYp4NpmyoZ5bI5Dg/nVSqaNhkPvkT04+xSuHxvvkx4HuMaSI9VT9QeuvL4h4inK89mQwXRkWI
 62Lwv3MDnS+sSWBM8BELAnzoycFUEKDqZLKxDauV41dkWPQO0/QgHixuhHyqm55X3TlpfGNV/7y
 6oG+3kHqWvLTjc3XuuHfvFFQHJgkoTzQrwkg7NjHMCEMmFiv4RQpV1YhFMUw5gsY+zu/geIF+A2
 WsiG7vLQd4gtme2dCQISMsjDfqPN7qMRZECuKgCtRVrBthI5vhfhG4cafNIHdnWioR2syQSpFBT
 UFHuNzfa+FVb0t2CiTnbXkNEkcMQ56FDVQv6C2CjGIL/6GxvREG1vNvB8mYc9/UNhPkgFiai1N3
 0dfUneZnxal7owiB0YA==
X-Proofpoint-ORIG-GUID: ZTar1XiXkf7Nd68qR1YrwjFW8Xj9v8it
X-Authority-Analysis: v=2.4 cv=E6xYNqdl c=1 sm=1 tr=0 ts=6ab882ed cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=lAqwrNyDy6uQVrA7iuQA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: ZTar1XiXkf7Nd68qR1YrwjFW8Xj9v8it
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270010
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UmVwbGFjZSB0aGUgc2hhcmVkIGFyY2hpdGVjdHVyYWwgZW50cnkgZmlyc3QsIHJlbGVhc2UgaXRz
IGxvY2ssIGFuZApvbmx5IHRoZW4gY2FsbCB0bGJfZmx1c2hfYWxsX2NwdXNfc3luY2VkKCkgd2hl
biBhIHZhbGlkIG1hcHBpbmcgd2FzCnJlcGxhY2VkLgoKVGhlIG9sZCBvcmRlcmluZyBmbHVzaGVk
IHJlbW90ZSBzb2Z0IFRMQnMgYmVmb3JlIHB1Ymxpc2hpbmcgdGhlCnJlcGxhY2VtZW50LCBhbGxv
d2luZyBhIHJlc3VtZWQgdkNQVSB0byByZWZpbGwgdGhlIHN0YWxlIG1hcHBpbmcuCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vaGV4X21tdS5jIHwgNiArKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4
X21tdS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCmluZGV4IGQ2ZWU3YzQwNzk4Li5hYTM1
ZjYzMTQ0NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2hleF9tbXUuYwpAQCAtMzEsMTQgKzMxLDEyIEBAIHZvaWQgaGV4X3RsYncoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGluZGV4LCB1aW50NjRfdCB2YWx1ZSkKIHsKICAg
ICB1aW50MzJfdCBteWlkeCA9IGZUTEJfTk9OUE9XMldSQVAoZlRMQl9JRFhNQVNLKGluZGV4KSk7
CiAgICAgSGV4YWdvblRMQlN0YXRlICp0bGIgPSBlbnZfYXJjaGNwdShlbnYpLT50bGI7Ci0gICAg
dWludDY0X3Qgb2xkX2VudHJ5ID0gaGV4YWdvbl90bGJfcmVhZCh0bGIsIG15aWR4KTsKLQorICAg
IHVpbnQ2NF90IG9sZF9lbnRyeSA9IGhleGFnb25fdGxiX3dyaXRlKHRsYiwgbXlpZHgsIHZhbHVl
KTsKICAgICBib29sIG9sZF9lbnRyeV92YWxpZCA9IGV4dHJhY3Q2NChvbGRfZW50cnksIDYzLCAx
KTsKICAgICBpZiAob2xkX2VudHJ5X3ZhbGlkICYmIGhleGFnb25fY3B1X21tdV9lbmFibGVkKGVu
dikpIHsKICAgICAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwotICAgICAgICB0bGJf
Zmx1c2goY3MpOworICAgICAgICB0bGJfZmx1c2hfYWxsX2NwdXNfc3luY2VkKGNzKTsKICAgICB9
Ci0gICAgaGV4YWdvbl90bGJfd3JpdGUodGxiLCBteWlkeCwgdmFsdWUpOwogICAgIGhleF9sb2df
dGxidyhteWlkeCwgdmFsdWUpOwogfQogCi0tIAoyLjM0LjEKCg==

