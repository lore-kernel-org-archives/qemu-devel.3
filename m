Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF3ECC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRfv-0003O6-9J; Thu, 15 Oct 2026 16:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfr-0003KC-SE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfq-0003EU-4g
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FDYOvm3462803
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ddWBTLhHgAc9FV3CbhTG4qIQiMPCXYrv384kVHt7OL0=; b=mUGuKmBrkrBJUGeQ
 ma7hju+EUp4iJGUJDVNtkzRbbeMXVhFlgH0M8za7V5/1reskfghzbLHS5KLp1bmv
 5tFna81V2jMr4OEJEuFVZ//cn09Of/+zq8yBGh3dyVs+enrPgLHMELx6KRYtkE8s
 TSTAo1g4a8l/W7ZSuYc8UTjciCElqxKxxyni0bA63qsQAiiN4lRsmnT/obvYMyO6
 sPpYH4ybLaP5lEHEqql1yYnUy58pIS6+spZ9OEjOkDzTcfD0Fnqcge+BivIoNlP0
 BGJa32ATqeHltE3UbWAsGxynGMRQ9a9PVbmN4oN3xJWnrt+bu8ywugs4qyWsupGC
 GFmJIw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69j6j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:33 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-182fd5bf1abso8974c88.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792094612; x=1792699412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ddWBTLhHgAc9FV3CbhTG4qIQiMPCXYrv384kVHt7OL0=;
 b=E3kG1bPYrKlMypyzeX2C75Y9Z+acTYdeJM6eu1yM/wA5XPRuF6B95eIJNbK2k4ylGN
 yQvOEOt2g5U1V8ujjwqi6JbyOFzCJwVEdRSC4tv0rJyRYNHzqjPgXMFrLsP7l6VFw0rn
 QS9fZEMVJCjd8PfJ9+jpuScC5UszdN3y+Kpi6DZglkS6pi7CVKTQNZ++Hwgt0FgSpHo5
 m1KM8zmmTjuDHC+pIRsgzGfcIa2B3q/5qtvHQEHMRI5jnfoaNzSdeLxbn6Z+mN+O1HMP
 qu5oHtBdZPnW2vGNI6DqqHn3rLSChT7RbklEgR9waPrB3a+a0TEHkN9SXH+nutBJmBwM
 nA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792094612; x=1792699412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ddWBTLhHgAc9FV3CbhTG4qIQiMPCXYrv384kVHt7OL0=;
 b=Km0fGvRb/Cxo3yRcgPBn8MCwaieDEQben8EhWAif38SnJstFlGJLgIFkt40LEgWV5e
 7o1AIL3tXn90VFMSxLUlX5iwxqToqQbwFDO8O6Y9BWz3PFT+Y+niUAufG7hmO7+6l/tL
 HBjwft47aLwOEF/wSu09lpGtRIyeO3Zm8lqW2MIUh04hEchpZHcmI1XEPumEqcyqCuQj
 /RB/Ifjg9nPXgumW7faIiqugPd10TT+DzpN6A1rD7mSHzNVEC0zCJVwdah8PSLJfBJ+j
 0c8V3jaxWnL6bnUvAvPB7e2pr9osIXeBAcAG6c+YngZi2mJgM0FSO9exlHYazdd1JOP7
 BlDQ==
X-Gm-Message-State: AFq9FYJQNUlSLDI+gJurMglF4lrqsE1tyC78RU8ejMf1D5NvD2kFOUU3
 gf//qA/xlEvol82kUnss6Ap9w9Ks0fHNbydSuP0W7urdZuWIdXpa16gTGZ9f6Vl82SqlkGnda55
 wRohMGwGkKFkR45ipcYA3epbLNs0fC2lXiiCpliVypy2L+baG6jDGL/5wTy6Sn1zbDA==
X-Gm-Gg: AYBFou1RXkFjGssePqtMFa5ktg9cWL00X4RPZIBFofD4IMPEFfZoT9vgKrFpfgEXFwB
 MwvmO/6U4aX8rHCHFm1gQgskwJob6croe8CZ4XuVW5vsKODkkXXpnBYA9w8ooAAfiU1vKjIXFE1
 NBIMXW7n+KT6s3iKH0Ht5ILv1DU5KGVJKTqt++aFe2fxutf6+twPUaGFNOv2PDChEa60P7PfO71
 fwo84l8u4ArHkeMJhbl50udvE9S+ENheKkObvRyWxhuAuO1ViKE6xXioKuYtqfAzxhYfdDPmlpG
 IiJ13biFjXyplRYhVOJC1/krl1MJE4/QjWksg3Cu3YCS5dV2zHWJtpfY4AIm18ZHBwCQT6muzSu
 df+W00VhV8b3Ru5qV3aPITFYiT6obEX2LXfadIUZbz4CmoM8=
X-Received: by 2002:a05:701b:2411:b0:170:aeef:a170 with SMTP id
 a92af1059eb24-170aeefa475mr20848163c88.36.1792094612133; 
 Thu, 15 Oct 2026 13:03:32 -0700 (PDT)
X-Received: by 2002:a05:701b:2411:b0:170:aeef:a170 with SMTP id
 a92af1059eb24-170aeefa475mr20848138c88.36.1792094611367; 
 Thu, 15 Oct 2026 13:03:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-182a6d6969asm1347058c88.12.2026.10.15.13.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 13:03:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 6/9] target/hexagon: wake K0 and TLB lock waiters
Date: Thu, 15 Oct 2026 13:03:03 -0700
Message-Id: <20261015200306.1602540-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
References: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: YfzDvk2pMSJrzZKJJGI1ibDAIBdyrsbY
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad13195 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=B3wVGE7vzLrs5E8uOrsA:9 a=YiozfWusF1qtVWxS:21
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: YfzDvk2pMSJrzZKJJGI1ibDAIBdyrsbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfXyYyH/MHYY1XL
 GZXEbBYNfEIYVGakUJTRzBjR3OhsH2M6dgXb5Frt/3H3Q/W/AojyLf/e1bsxi0XeaxA74cq3KNP
 7ibmCSShvK2m8JvVjpwm2YtMpKbeEJBCVMO9Uu7S3JJqTu4afVoThokRGKAxCjMh+cIvndLp5Tm
 Nkf+aM8xgY+LiNzm2Ds9AeOXaI+VL/1rxuf+uVBPcOYcTBUa2bivM4AnI4v4vaROz51LWGLHhgF
 QBs1R3URyfU2lOP5njGs1mCY5czZ2nPqeR6zNAlR/vb4AByXmlYPiD5raGuKqd+YNpx+cGoBvrO
 ppf09ZGzsKB3biUhKXJ6kpniFa8arxqE78GHl0v25CJOGBa+ayiXwEx6Q5f0WKgcgIA+j8Mjpy3
 hiPjWJVmyogWJ66NT9HC59Vk5k9OSNsdILEk+ns9Ax77vmx/80vsETagsYjmDWwz4REeq3WVqMv
 F4UxiiQLv8Hsq5b+P+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfX4jpoSAg2TXgT
 5p1emcaSNrhqnVmjtJUomjT7MSsnLjIFPQ5uI171dd2VnDLbNyRkyytiVP6h002W6L9Jxr/GZQc
 0g91bvmsR8jsQHAMdhvo5xAmZ66vSNI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150079
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

V2FrZSB0aGUgc2VsZWN0ZWQgSzAgb3IgVExCIGxvY2sgd2FpdGVyIHdoZW4gb3duZXJzaGlwIHBh
c3Nlcy4gVXBkYXRlIGl0cwppbnRlcnJ1cHQgc3RhdGUgYW5kIGtpY2sgdGhlIHZDUFUuCgpSZXZp
ZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0u
Y29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jICAgICB8IDIgKysKIHRhcmdldC9o
ZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgfCA4ICsrKysrKy0tCiB0YXJnZXQvaGV4YWdvbi9oZXhf
bW11LmMgICAgICAgIHwgMyArKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgfCAy
ICsrCiA0IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24v
Y3B1X2hlbHBlci5jCmluZGV4IDFmZGQ4MWFkOWI0Li42ZjE3MjI3MDg2NSAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuYwpAQCAtMzczLDYgKzM3Myw3IEBAIHN0YXRpYyB1aW50MzJfdCBzZXRfZW5hYmxlX21hc2so
Q1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVM
RChNT0RFQ1RMX0UsIG1vZGVjdGwpOwogICAgIHRocmVhZF9lbmFibGVkX21hc2sgfD0gMHgxIDw8
IGVudi0+dGhyZWFkSWQ7CiAgICAgU0VUX1NZU1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX01PREVD
VEwsIE1PREVDVExfRSwgdGhyZWFkX2VuYWJsZWRfbWFzayk7CisgICAgaGV4X2ludGVycnVwdF91
cGRhdGUoZW52KTsKICAgICByZXR1cm4gdGhyZWFkX2VuYWJsZWRfbWFzazsKIH0KIApAQCAtMzkz
LDYgKzM5NCw3IEBAIHN0YXRpYyB1aW50MzJfdCBjbGVhcl9lbmFibGVfbWFzayhDUFVIZXhhZ29u
U3RhdGUgKmVudikKICAgICB0aHJlYWRfZW5hYmxlZF9tYXNrID0gR0VUX0ZJRUxEKE1PREVDVExf
RSwgbW9kZWN0bCk7CiAgICAgdGhyZWFkX2VuYWJsZWRfbWFzayAmPSB+KDB4MSA8PCBlbnYtPnRo
cmVhZElkKTsKICAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVYX1NSRUdfTU9ERUNUTCwgTU9E
RUNUTF9FLCB0aHJlYWRfZW5hYmxlZF9tYXNrKTsKKyAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShl
bnYpOwogICAgIHJldHVybiB0aHJlYWRfZW5hYmxlZF9tYXNrOwogfQogc3RhdGljIHZvaWQgZG9f
c3RhcnRfdGhyZWFkKENQVVN0YXRlICpjcywgcnVuX29uX2NwdV9kYXRhIHRiZCkKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgYi90YXJnZXQvaGV4YWdvbi9oZXhf
aW50ZXJydXB0cy5jCmluZGV4IGFiNjZkNTQ4YTFlLi4wM2UxZjI4ZGE5YiAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhf
aW50ZXJydXB0cy5jCkBAIC0yNDAsOCArMjQwLDEwIEBAIHN0YXRpYyBib29sIGhleF9pc19xdWFs
aWZpZWRfZm9yX2ludChDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IGludF9udW0pCiAgICAgYm9v
bCBzc3JfaWUgPSBnZXRfc3NyX2llKGVudik7CiAgICAgYm9vbCBzc3JfZXggPSBnZXRfc3NyX2V4
KGVudik7CiAgICAgYm9vbCBpbWFzayA9IGdldF9pbWFza19iaXQoZW52LCBpbnRfbnVtKTsKKyAg
ICBib29sIGxvY2tfcGVuZGluZyA9IGVudi0+azBfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19VTkxP
Q0tFRCB8fAorICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50bGJfbG9ja19zdGF0ZSAhPSBI
RVhfTE9DS19VTkxPQ0tFRDsKIAotICAgIHJldHVybiBzeXNjZmdfZ2llICYmICFpYWQgJiYgc3Ny
X2llICYmICFzc3JfZXggJiYgIWltYXNrOworICAgIHJldHVybiBzeXNjZmdfZ2llICYmICFpYWQg
JiYgc3NyX2llICYmICFzc3JfZXggJiYgIWltYXNrICYmICFsb2NrX3BlbmRpbmc7CiB9CiAKIHN0
YXRpYyB2b2lkIGNsZWFyX3BlbmRpbmdfbG9ja3MoQ1BVSGV4YWdvblN0YXRlICplbnYpCkBAIC0y
NTcsNyArMjU5LDkgQEAgc3RhdGljIHZvaWQgY2xlYXJfcGVuZGluZ19sb2NrcyhDUFVIZXhhZ29u
U3RhdGUgKmVudikKIAogc3RhdGljIGJvb2wgc2hvdWxkX25vdF9leGVjKENQVUhleGFnb25TdGF0
ZSAqZW52KQogewotICAgIHJldHVybiAoZ2V0X2V4ZV9tb2RlKGVudikgPT0gSEVYX0VYRV9NT0RF
X1dBSVQpOworICAgIHJldHVybiBnZXRfZXhlX21vZGUoZW52KSA9PSBIRVhfRVhFX01PREVfV0FJ
VCB8fAorICAgICAgICAgICBlbnYtPmswX2xvY2tfc3RhdGUgPT0gSEVYX0xPQ0tfV0FJVElORyB8
fAorICAgICAgICAgICBlbnYtPnRsYl9sb2NrX3N0YXRlID09IEhFWF9MT0NLX1dBSVRJTkc7CiB9
CiAKIHN0YXRpYyB2b2lkIHJlc3RvcmVfc3RhdGUoQ1BVSGV4YWdvblN0YXRlICplbnYsIGJvb2wg
aW50X2FjY2VwdGVkKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jIGIvdGFy
Z2V0L2hleGFnb24vaGV4X21tdS5jCmluZGV4IDBjYTUyZWQ2NjZkLi42Mzc4NzNiMjY2OCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
eF9tbXUuYwpAQCAtMTksNiArMTksNyBAQAogI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNs
dWRlICJody9oZXhhZ29uL2hleGFnb25fdGxiLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhh
Z29uX2dsb2JhbHJlZy5oIgorI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCiAKIHN0YXRpYyBp
bmxpbmUgdm9pZCBoZXhfbG9nX3RsYncodWludDMyX3QgaW5kZXgsIHVpbnQ2NF90IGVudHJ5KQog
ewpAQCAtMjcxLDYgKzI3Miw4IEBAIHZvaWQgaGV4X3RsYl91bmxvY2soQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiAgICAgICAgIHVubG9ja190aHJlYWQtPnRsYl9sb2NrX3N0YXRlID0gSEVYX0xPQ0tf
UVVFVUVEOwogICAgICAgICBTRVRfU1lTQ0ZHX0ZJRUxEKHVubG9ja190aHJlYWQsIFNZU0NGR19U
TEJMT0NLLCAxKTsKICAgICAgICAgY3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9UTEJf
VU5MT0NLKTsKKyAgICAgICAgaGV4X2ludGVycnVwdF91cGRhdGUodW5sb2NrX3RocmVhZCk7Cisg
ICAgICAgIHFlbXVfY3B1X2tpY2soY3MpOwogICAgIH0KIAogICAgIGlmIChxZW11X2xvZ2xldmVs
X21hc2soQ1BVX0xPR19NTVUpKSB7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDhjMjkyODU0ZGUzLi44MmQz
OGRjMGIwOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTEzOTcsNiArMTM5Nyw4IEBAIHN0YXRpYyB2b2lk
IGhleF9rMF91bmxvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgIHVubG9ja190aHJl
YWQtPmswX2xvY2tfc3RhdGUgPSBIRVhfTE9DS19RVUVVRUQ7CiAgICAgICAgIFNFVF9TWVNDRkdf
RklFTEQodW5sb2NrX3RocmVhZCwgU1lTQ0ZHX0swTE9DSywgMSk7CiAgICAgICAgIGNwdV9pbnRl
cnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSzBfVU5MT0NLKTsKKyAgICAgICAgaGV4X2ludGVycnVw
dF91cGRhdGUodW5sb2NrX3RocmVhZCk7CisgICAgICAgIHFlbXVfY3B1X2tpY2soY3MpOwogICAg
IH0KIAogfQotLSAKMi4zNC4xCgo=

