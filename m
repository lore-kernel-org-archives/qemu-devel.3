Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738EBCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifN-0003p9-NH; Fri, 19 Jun 2026 19:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifC-0003mC-Ue
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifB-0007NU-B8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYSNE1337254
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=; b=cJXH211dMPQhcXb0
 77ZmFpmCmcESdoxJxYxVSf4wi5IsE1dhFftJDAScUdSdqe+/ar+jW78Y+obdOMB/
 ltpfYNTrG8Vwl/XA9phsjWgvIPpi+GHeSp4tLOM3BnFV0fE4byKP/st704B/8Y7A
 SAR4SZZzYdLWqWy/gC4BIC/jt2FwEB0ldGXRk+pKZB6BgsxmPQmiqlU+o4zBQyQB
 kNYWX+/5OYlzQGGVI0vt0ryVn++5lMnwSkF2Dw2KM7mWZV/6c1wecPhlJCIUJasF
 zFntxhzFXd/HU8CgM93k61a3u8ppK+z1XmsANA6BZCy8VHK8uodgXU3CdUh/hHBZ
 RVwFtQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp67578s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so568290eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911814; x=1782516614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=UPBGbjtSl9sbrL/72Eg1SvoBDXB1Cn+x8wlJa6QFrFxDHJpjOhijCbk8r3LLlZl9VW
 eIz/t14UJaO79AZPjVWOZ1g9TW8PpfFx1TCWPYkqbfopE4cy1mPP6h+0RoFsIiwS4iSV
 xrM72iXwEs3S10j32wF1OPp/fb3gMcsTUeuQLlYfjCwdoccNQjBn1ls4uNxaPMhrjJaL
 Fjkt9IKmu72R9bbnMccbLILZUKARZKk5WT3tPwrdYUET06EB2Yv5U0Dql/RXultL0IsI
 9cRNxstBb1g55GmD3vEtZVYrka+Z6oDI2eJC7cPK3/ckVHNnnBtLSxPvKh649kjMHDQ1
 kRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911814; x=1782516614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i/UBxztk9FzNckObXXg5AeElk2tIk+IMNK3xdbJ6LSM=;
 b=gA6MtkaAxS5dqYI4RXYTvgVZNUjo3owi4ZfE1J9OzKhbl1Z1zA42SfKaJ01IjCFN5h
 phTjEhfbabwE0K/GRuwXY8Pt7XuaPD58l92jkIG2peBAOaY4A1C5oSSyHuLfq+SmyIje
 iePf6U5dZKZA+eyWTZC+mWwUTDQUdOxRGWsbrx4PRXie0DAK8WV5oieRW3qtCj20d5HK
 gtBQJ5DUXNKDssFsq3HCHREjdzXwSwFUct1u8zShfiz6rPmx5Gi3VH9OEvrbyCL+vwVi
 0FqBkm/0u9vaslSP8ClE0jYA5O7A2t3fHQTW1edII6AamGjwHmYfggIijnA5UOpo3+nR
 Zwsg==
X-Gm-Message-State: AOJu0YwcbPZcc00FLSbTNvZsQfYTSn8ul/A6xgJrLmwWyS5gzdV6U3c2
 Z4AccjmAW2WgRzP6B6qY8kB+rACNTFXiZ78gAjBTByB9AhktU+RHaOLqosr3cjFwhg8dfpndSum
 zLmdZbiuM3ALBSWvu4exNtXDlsWNCKHB4UiZ3ZvtKOgO/836Vwl/VpIyiA+1aDpUv2g==
X-Gm-Gg: AfdE7ckcOouUcwy5LgN+Xnj3691hDziYAmelorlLlunCOGQprqTOH40Bj6ROAtyYJAW
 JRF6HMdGoJJWhzQY3Zfq+KGCEc1EbFfK24aQXz/2ajiZkc7NYh/Qf69h66UeVev5PrKec4nH4++
 B+C6dEkoHZhBGY/afKPhTbf0vw8LT31bLkeVWOnO4H3mHpv6Xd254naqmuGunxdKg9meX+v8WjN
 U7MX57YlWOR7jqo15dKFUC0pPUNlkRIsBMO8FdCLF2N1UqpKBj03EpYOu1K2QCt7qw2Ku6RlszA
 CxxPOJ4SVhH9KIQeXUoI1anUw5F1QJK4uck48nbaSDE2fOCZ3TC8Jb4AnniCSStdGqr/z7wzA88
 UbygMysgjlsUnHu9PP/0tLNWurllogZdBdDFfZtIbEdIp0N6wqe0qfJKiw80=
X-Received: by 2002:a05:693c:3105:b0:304:dd1c:737e with SMTP id
 5a478bee46e88-30c07156ec1mr3453578eec.16.1781911813977; 
 Fri, 19 Jun 2026 16:30:13 -0700 (PDT)
X-Received: by 2002:a05:693c:3105:b0:304:dd1c:737e with SMTP id
 5a478bee46e88-30c07156ec1mr3453559eec.16.1781911813424; 
 Fri, 19 Jun 2026 16:30:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 40/74] target/hexagon: Implement {g,s}etimask helpers
Date: Fri, 19 Jun 2026 15:58:37 -0700
Message-Id: <20260619225911.159473-41-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: o_WirfrDw_yJoCtz-OA0gAy9iiAd8LF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX7BfMHFWu+ODJ
 U5n4MzkHRenaVPaQ8ErsZ43aLVHCSNHcgmiMoNRYebeZb6VtAiPQJmnW0gUjGi/yNydMe7DV29E
 6F1lLDU9hE2Ug796mRFgkj++/JFICVb2qlj2k6aVcZbnUqcZ2d5/1GTVeZ7gC03FyCMIffSE1wU
 crcyOabatpnuinicbSHipABEu8dWswvgI59vtQH7vW1QEQQYxKxa7VwzHwmpJ+ShOSB8R7UlJLs
 FSzfHUKJnTmw/23gclZmUeLf6yb6FGzL9wSeonj+44ExyLy7BiE4dSh8re9Onrb7U/BSEJ3Ih5z
 uN71H2hurIWqqLRCxmK3Is6L/Il9/PLfQawum/GceCH9nQJbTBNElZ6rkgnrLvC5f2yzRPMBFAG
 mQTC9+Ktrip5UKSM1LcD0WG7WfJHb0Kue83g85sjfxJ49EfNXMhXcCVp8wm85Xiau32cCg0L5lr
 A1Pjo7ZAT9xMYilYaRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX5w0F7gvqVRBw
 DlMqgL0mSFmApJiI2DnUc4zdhUoIO3hJhtw/9Q1WKADmi0C2WaND97UOJ5+zZM7f9Yhezp3JOSp
 KXwxgnMAWR/urCFJWM9jzdU45odiIcQ=
X-Proofpoint-GUID: o_WirfrDw_yJoCtz-OA0gAy9iiAd8LF5
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35d106 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=he7afFXPmx5H4pWyvLYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IGI5Y2YxZjE4OGJiLi4xNjgwZTMwMGVjNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0OTks
MTIgKzE0OTksNDQgQEAgdm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgdGlkKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cisg
ICAgQ1BVU3RhdGUgKmNzOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0go
Y3MpIHsKKyAgICAgICAgSGV4YWdvbkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOwor
ICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAg
ICAgICAgaWYgKGZvdW5kX2Vudi0+dGhyZWFkSWQgPT0gdGlkKSB7CisgICAgICAgICAgICB1aW50
MzJfdCBpbWFzayA9IGZvdW5kX2Vudi0+dF9zcmVnW0hFWF9TUkVHX0lNQVNLXTsKKyAgICAgICAg
ICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAiIGltYXNrID0gMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICh1aW50MzJfdClHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2sp
KTsKKyAgICAgICAgICAgIHJldHVybiBHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIHJldHVybiAwOwogfQogCiB2b2lkIEhFTFBFUihzZXRpbWFzayko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRpZCwgdWludDMyX3QgaW1hc2spCiB7Ci0g
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBDUFVTdGF0ZSAqY3M7CisKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIEhleGFnb25DUFUg
KmZvdW5kX2NwdSA9IEhFWEFHT05fQ1BVKGNzKTsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICpm
b3VuZF9lbnYgPSAmZm91bmRfY3B1LT5lbnY7CisKKyAgICAgICAgaWYgKHRpZCA9PSBmb3VuZF9l
bnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5kX2Vudiwg
SEVYX1NSRUdfSU1BU0ssIElNQVNLX01BU0ssIGltYXNrKTsKKyAgICAgICAgICAgIHFlbXVfbG9n
X21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAiIGltYXNrIDB4JSIgUFJJeDMyICJcbiIsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBmb3VuZF9lbnYtPnRocmVhZElkLCBpbWFzayk7CisgICAgICAg
ICAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShmb3VuZF9lbnYpOworICAgICAgICAgICAgcmV0dXJu
OworICAgICAgICB9CisgICAgfQorICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLAor
ICAgICAgICAgICAgICAgICAgInNldGltYXNrIHVzZWQgd2l0aCBhbiBpbnZhbGlkIHRpZCBuZWFy
IFBDOiAweCUiCisgICAgICAgICAgICAgICAgICBQUkl4MzIgIlxuIiwgZW52LT5uZXh0X1BDKTsK
IH0KIAogdm9pZCBIRUxQRVIoc3JlZ193cml0ZV9tYXNrZWQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHZhbCkKLS0gCjIuMzQuMQoK

