Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AE606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iaJAD59p;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fJ0dq50l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1mV-0004xM-7Y; Thu, 22 Oct 2026 19:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mO-0004wX-I8
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mM-0001zL-NB
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMFCeY957408
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=; b=iaJAD59pju5ds3C5
 Y99oGzYXz1LHVBJwbQCJZQxvFMmvapSdpvL/yh4G13wvAjlR6So9P1NbvR8kWCDL
 tZNiDvZNcTcMCTvsMrbfP2F7+17WsNMBa8+cV1DERfLBPzlhPwXX7NB2sGT+YotC
 +DTqLHFrKXYUux2CQkfoYVzY3Zk8IWPVR2+Rihtj4Sr2ZZuBIFi/y7IMdy70su80
 NZnviuspGyhpkR3OBkDfBzpodTCyWOLug2CHJAbgxrWVJKSiyl790EcANQajmET5
 YV0Q9435nZmaeQlvKV6ZHuaWmN3c0BMwkqin0XDo4STq2anTcgp9e15wY+Bb6Tht
 ROwrUw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk8bq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:00:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3580c07911eso873464eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792710056; x=1793314856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=fJ0dq50lBPd2msnfKRGIEzkayvRgsJ5LDZrlB5iTkOmF1SGtyfYELKcZVS18fuv0yh
 d15dOrf0OeOOH5ekJLfHJ+BSezFVLX6EppyBq+uoNatJr+T+KqDEKBNEKXtg5fqLlDVf
 9w7av2Y5ZM47UlVKURMYmhJgdcPJD47WoZWiTBOHFKQbXNnI3cEzqOV8q7SVLzAQkmjv
 azSJiV6etY348fHAYid9tUw6k9UHOjFmXx6gwT7TJPxbaMuaLqWO9tdwkagPz6lA85KD
 bGGeMAV/ezK2cb4q2wLkMNovi+Ki11GjYyYRPhoYM+xgdfgMtAareQFeef2s7wgVrpte
 tGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710056; x=1793314856;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=O2+89n9bTs/KXnYfNCLW43vtQ3UXWRZYlfAJi+OXEYnBbm5IZxv3zEiCWhki/HM6ra
 mlWicn86tdL/cVKGUf4ciPizLiV6G48xQi7Pkm1RBzlvnISvTs24TCCzsgql7OGx8f1A
 rY7v6baLu/LRFT5XHO1Ak5DH46A4cjxXakQCDzDRpMVpgYfLgCb0KDxHwONreCaXFCaf
 kQBsqtGmXwW2KlxN6rD5w/OYyt3G9vH0pfk9KkUZ74pCyTf7k8nh9hrSm4uugmnj2gWl
 vJtaHrbPCbquffvFEhKmQsEp7rtX82xk3W00fw9usDHV9PNfTkeNAysAe1/njgNcPRcb
 l92A==
X-Gm-Message-State: AFq9FYK/PjITymOLyN36hMhpQ326o6Ib+HMQ+jOPo/NZ6GDIs33146d6
 oGsPmDslXwNVk4FTLtFwN54c3ccAmtmunaH9y4simLFwYQGidBErUVOwn+wwuRc/0Wq+cxlWvxt
 L9chrtSKze8lSEHmf1nQ/J6c7DL38cEjCdeg6fwlIyutOFHSJsiv2e+B22cIvIFh0Ng==
X-Gm-Gg: AYBFou2o9eolTFtQzXSsuIBoTLDbyIjNQS4BGJed+qYD9vaMF8JgGksdSFFl1dlyMeo
 vwIgscoF39A6jxxTuQjLGrGSom2jCRFxjU1UXvyjouOAk3tH7Be6EGRs43+eOI2f4xzGLXHqUWn
 bHSOC55ovdaXVSWeP+oh/rL22VRNd0eXbwRFUEGs/ObsNAlPiZxfZeaSv0dNJ9zCxe0MKxRWowu
 +WDG2wTagfs87Se3pcJSI7QxCjZDhoarnb6udFq8grObqutYyOUBlJO3g1wMo9O8U3yEP7EYaU9
 xEKtc42jpw63T9QvUs16/9cvgzbP8cURYrIMRdH1t/qfha0doG0z1kbbnsYny//NmAwvG5Mdts5
 PwZ//tGWC02tASeChriuy2gLnYAF0+yCkEaa9DM2MnPuKIMjR
X-Received: by 2002:a05:7300:372b:b0:369:860e:47c9 with SMTP id
 5a478bee46e88-369d976ca32mr1034434eec.17.1792710055533; 
 Thu, 22 Oct 2026 16:00:55 -0700 (PDT)
X-Received: by 2002:a05:7300:372b:b0:369:860e:47c9 with SMTP id
 5a478bee46e88-369d976ca32mr1034381eec.17.1792710054839; 
 Thu, 22 Oct 2026 16:00:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c0e60dsm1088138eec.2.2026.10.22.16.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:00:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 02/16] linux-user/hexagon: report ISA HWCAP through v85
Date: Thu, 22 Oct 2026 16:00:34 -0700
Message-Id: <20261022230048.2160400-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX9EbHS1msW8d2
 e34StLA8ayN9C8gX11MprdJoZlJiuVC9DCI4Kux4ATf62zsQgLlfILY/IGpmbKtTbJ+XFwgI8+o
 hEETi8AyXzK1aT/f1o3qKwOF1NP/24/RTUg9pOMDBBRcERSuwju48mBOj8Fqx+agy3fOWP2jYBo
 +TwzJu5GfpSJ2wtyvRyHJV8QTdqs7uQuYYN32m3PCAnCGT5cF1by36vTxEjjaBnsqOfXShB2310
 wxpHNanQDzauyn8PU8VaVAndb+LaazMWL3mNoTuByy+UDvKuFF+bXA4JY0wbSYK7Ev3Kvs6RDo1
 tmMkLLFBAodMUKPCsGC1nibm2RXoHTvkgmdv2flMOQ6wKxY1/bhYem9hUGTyGYoxVuTr7ubgiZ8
 FVUo8x3W3ZPe1tRZqpxK8FFDRlrvS24+FQDAMM5O9EgtEdOqaPkz1WYdDSTSqHCo7VCzIRZolmF
 715DzlI2qGgMOgZPsfw==
X-Proofpoint-ORIG-GUID: 8PQWB0yEuUqg6Ks-uzmmTXJZ4B0_C6YF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX2TSoLFdmVCOz
 90z9eIiqpdVBFHOphwkpX17emqEEaAWfNJO+Vmsi+vlmFI4SsaPGhSb65QQSpPcm4CwDbslbeYy
 ib3u8ZDL7BKOBXloKS+1jOc1gmS8t3s=
X-Proofpoint-GUID: 8PQWB0yEuUqg6Ks-uzmmTXJZ4B0_C6YF
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada95a8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oIHwgMiArKwogbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRf
ZWxmLmggYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCmluZGV4IDkwZTUwMzJkNWFh
Li5iMWViNWVhNTAzNyAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYu
aAorKysgYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCkBAIC00Myw2ICs0Myw4IEBA
IGVudW0gewogICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3NyAgICAgICAgICAgPSAxNiwKICAgICBI
V0NBUF9IRVhBR09OX0lTQV9WNzkgICAgICAgICAgID0gMTcsCiAgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjgxICAgICAgICAgICA9IDE4LAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y4MyAgICAgICAg
ICAgPSAxOSwKKyAgICBIV0NBUF9IRVhBR09OX0lTQV9WODUgICAgICAgICAgID0gMjAsCiAgICAg
SFdDQVBfSEVYQUdPTl9IVlggICAgICAgICAgICAgICA9IDEgPDwgNywKICAgICBIV0NBUF9IRVhB
R09OX0NBQkFDICAgICAgICAgICAgID0gMSA8PCA4LAogICAgIEhXQ0FQX0hFWEFHT05fSFZYX0xF
TkdUSF8xMjhCICAgPSAxIDw8IDksCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vZWxm
bG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA5Zjk4YWQ4ZmI4Ni4u
ZGIwYmYyOTljYzAgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKKysr
IGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNjIsNiArNjIsMTIgQEAgYWJpX3Vs
b25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WODE6CiAg
ICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKICAgICAgICAgYnJlYWs7Cisg
ICAgY2FzZSBIRVhfVkVSX1Y4MzoKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0Ff
VjgzOworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjg1OgorICAgICAgICBod2Nh
cHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WODU7CisgICAgICAgIGJyZWFrOwogICAgIGRlZmF1bHQ6
CiAgICAgICAgIHJldHVybiAwOwogICAgIH0KLS0gCjIuMzQuMQoK

