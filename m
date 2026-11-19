Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D4606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gJDJvTRh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jC/bpmqF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8Yc-0002sd-LU; Thu, 19 Nov 2026 15:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YR-0002ok-EU
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YN-0000qn-US
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:23 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1k7X3148672
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZKkjp8ZF9dSvEd5w4xKjfynBBPgKoKDszWTxlq1VmKQ=; b=gJDJvTRhb6nJpQQU
 Xp4JCmA1tr4pqUDz6OIUgh0/GB7pog/bXd5Rs5NkJ+93b/ofvwr47ByySAYLQSqD
 e0iJ6XicJ5Xalr0zSjkeuo+hHY5shnsLGFqZIklLPIdJNISIhqVq9EfpIYuIYQy/
 6+GmP8J9Gz8UMRXJwWlczsLToZUdvWf1klm/F9pEwa/kPhfoQQiNvgXITjaX+Tg7
 iCLTEQo3fOrJJgYy8B0T5HNg7iVNIT7gZMAHcX+AjoIVqoFCuKWSENzcc8lIR/8y
 KFKiNciTfc1WUwBg/5qzh6BAcDqfFHLE9gjUVZBHvl42rcf995A8wL1ex/9KETgC
 nUCpMg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx6ah2t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3724667bc16so64026eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119373; x=1795724173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZKkjp8ZF9dSvEd5w4xKjfynBBPgKoKDszWTxlq1VmKQ=;
 b=jC/bpmqF8WhHOAW/sn7RmLRmJdhXzDDGwNGLZ9edaklZgh59Qem/2TRIpplP1z5ODY
 W4K/xHEB6F4SMwyl9ueKU1M4wAg1quephMspdahtewSe9AUiurLjQ5g9098IFod8nSgd
 Wottm/bro9de/t8HMRoecGLmkZ16/6NMgTrXPd79+l0GjWU6vxdCg/o4XfjzoGjJ19Sp
 y4X2JsvooBS3ALGuZrySf5XEajHdCxdvML9TvqHfX/YKfPWFoL+gs0a3If+N1B8x6KhS
 3ix0hp+fup6IagLVe067kS0hO4+g67oY18rfANUX3Cou4LNEFuh7yQ3TYz8qr+43BuZ9
 rt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119373; x=1795724173;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZKkjp8ZF9dSvEd5w4xKjfynBBPgKoKDszWTxlq1VmKQ=;
 b=1X88p3XEij0GCmduHDuaqFxfOEMNoWbvKsumLb8ai8L14Cw+m9xHrYLT8ICorZRU4r
 Pcgfv2px4emDDhnPTZsXlzvg/0qh7u+88fiNLN/u3+n8A+o2MM3i9erUzXCU49Ge9d+2
 o7sA8lk5h7uY9kfFqHaYAf26NfEH6iOdF/1LNKuayxp8V6k1ZU5+E8OgPfU4TOUZCq3y
 mrvUqfr8AgMkLvKgisqCX1W+s3tX1uFEaBgaDe8vwcscR5yRtHl82touHCOAzqtFnQ9O
 8euZ/kMySkY/74ZXMZP4cmwp0ODQK5halNWyunRlyvi7LhMbGoHQdKLIVwbWSBlDkN84
 LwMA==
X-Gm-Message-State: APuU4Z/h3q0GcZnyPRq1AfQx/3gULdfRzyR+uOsthxM11dYURnPtOvvm
 I51lPBqYOP8lnQmtvOQD7q/JWhk0c8nJrU5jUKXXSeN1Uj4C1R0+C1k04j1qRDUKxkAwB56NnjZ
 NP31Ebl7/SR9/wzywfjU/aJpBaLk6BEoDfIhMw2z24wtwcPUQmFs7KjCbQyTeb5eswQ==
X-Gm-Gg: AZFdTZcIndnWasmunov1Jp0RtyI6U3Ei2raeFsV1NohE3+smsWj0ag7JJu81gm8TFox
 zxtE1IBsyAfmYkUapyrT6kVMeZZg8PXZ1v4sI7gG0fY0lvwiLyjvy4IkrACpc5qMQoEwi/fWRCh
 TzR56cvE9oRWuCa6dmGA2Xbd7ri9VVS5jb4TpOuTsyvYzGegFjoO/9SEpjwza6XqiHHSvYHWKsp
 8FsR/HRR/gCtDtcQWhbZZ35/G2DBmokj6wc8P3qIy9LmWISkkUPHJsH+fgSaJIYdhnVIPl4yddK
 b9h6L17vnVVcvBb8tsz3HAKnQW8IHN8jDrc7sgyT3o6X/4uCDKUuxQYRmsv8vAAO3gg4W8SyxjD
 erfRy4mNmYS81tnZAN+F6aDDYjmjcNXrclrseSRhntVCtcSj3qIxcQu3Rt2p8G5pY+1mMT40qP9
 74nNArPn9KEo46Z3SoVZXhHg==
X-Received: by 2002:a05:7300:6b0a:b0:382:75b5:e77 with SMTP id
 5a478bee46e88-384b4a80eeemr1971046eec.25.1795119372909; 
 Thu, 19 Nov 2026 12:16:12 -0800 (PST)
X-Received: by 2002:a05:7300:6b0a:b0:382:75b5:e77 with SMTP id
 5a478bee46e88-384b4a80eeemr1971016eec.25.1795119372247; 
 Thu, 19 Nov 2026 12:16:12 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:11 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-11.2 05/14] target/hexagon: report the faulting packet for
 stack limit exceptions
Date: Thu, 19 Nov 2026 12:15:54 -0800
Message-Id: <20261119201603.2377989-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Lzu4OPwk5fazRJzxMafAL5sgV6deDto6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX7eGRF4zo54BD
 lnvWATDJJoV5jIwfuxWpJIueVILMsaGJeTZtcb+ViBbkJHbbzo39AKQ2efcux9UD/bndVAnKPxh
 gujh+eQdo4PR6GgkD68CDGycI7KL3Qw=
X-Proofpoint-ORIG-GUID: Lzu4OPwk5fazRJzxMafAL5sgV6deDto6
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6aff590d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ctcHP5N1X2NQA3O8W1oA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfXxB0MrWm5JFf2
 J0741eWM8BCwzjMde52y+XrXPBXruQbb89EH1kyMfnpXFrMfHM++MJlZaSA18co8n59Fu6zA72F
 3zP8K/QMxehxRnuM3sOB+W4X4la1ny1QDBQAwBI8dHJ9mgrYcHrvY7AAEkLkPEbAZi7ICO1oKng
 KDldYVUHAKozMdMYky452AN4lYtaSTkfakLKeHAgssJ85CVF0dPQh3AO8LOvIIhqC8H6cfXKoim
 pJt6bifoxL0QD7CzLl0qPr5KhXTSFjaQHsjeeWh/MYdexXjm7ZTe+K2WzgWCW+m0Tyvc/YZmYrq
 yHRgDT7enf6v/pUkpr8moQ902x/ub1fLLWjQowNvZca4C/eYwa4pf8krmY+GbNzbKY5GR4462ct
 2vvYKOm/y3YmUj3SsCPyYh58TWrWhCsCRcuVyIFxYdwS3DiWNqAXlbgGngpmdjGc6kW3Ve3slsK
 i4p87SRCAHG8toT4U1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190080
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

VGhlIHN0YWNrIGxpbWl0IGNoZWNrIHJhaXNlZCB0aGUgZXhjZXB0aW9uIGZyb20gYSBoZWxwZXIg
d2l0aG91dAp1cGRhdGluZyB0aGUgUEMgcmVnaXN0ZXIsIHdoaWNoIGlzIG5vdCBrZXB0IGN1cnJl
bnQgd2hpbGUgYSBwYWNrZXQgcnVucy4KVGhlIGV4Y2VwdGlvbidzIEVMUiB3YXMgd2hhdGV2ZXIg
UEMgd2FzIGxhc3Qgd3JpdHRlbiwgc28gYSBoYW5kbGVyIHRoYXQKc2tpcHBlZCB0aGUgZmF1bHRp
bmcgYWxsb2NmcmFtZSByZXN1bWVkIGF0IGFuIGVhcmxpZXIgcGFja2V0IGFuZCB0b29rCnRoZSBz
YW1lIGV4Y2VwdGlvbiBmb3JldmVyLiAgUGFzcyB0aGUgcGFja2V0J3MgUEMgdG8gdGhlIGhlbHBl
ci4KClRoaXMgZW5hYmxlcyB0aGUgZnJhbWVsaW1pdCBzeXN0ZXN0LgoKU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhh
Z29uL2hlbHBlci5oICAgICAgICAgICAgICAgICAgIHwgMiArLQogdGFyZ2V0L2hleGFnb24vZ2Vu
cHRyLmMgICAgICAgICAgICAgICAgICAgfCAzICsrLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMgICAgICAgICAgICAgICAgfCA0ICsrKy0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X3N5c3Rlc3RzLnB5IHwgNSArKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIv
dGFyZ2V0L2hleGFnb24vaGVscGVyLmgKaW5kZXggMjkyY2E4ZWI3YzUuLmU2NThmODA2OGY0IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9o
ZWxwZXIuaApAQCAtMTU4LDcgKzE1OCw3IEBAIERFRl9IRUxQRVJfNShpbnNuX2NhY2hlX29wLCB2
b2lkLCBlbnYsIGkzMiwgaW50LCBpbnQsIGkzMikKICNlbmRpZgogCiAjaWYgIWRlZmluZWQoQ09O
RklHX1VTRVJfT05MWSkKLURFRl9IRUxQRVJfMyhyYWlzZV9zdGFja19vdmVyZmxvdywgdm9pZCwg
ZW52LCBpMzIsIGkzMikKK0RFRl9IRUxQRVJfNChyYWlzZV9zdGFja19vdmVyZmxvdywgdm9pZCwg
ZW52LCBpMzIsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8yKHN3aSwgdm9pZCwgZW52LCBpMzIpCiBE
RUZfSEVMUEVSXzIoY3N3aSwgdm9pZCwgZW52LCBpMzIpCiBERUZfSEVMUEVSXzIoY2lhZCwgdm9p
ZCwgZW52LCBpMzIpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3Rhcmdl
dC9oZXhhZ29uL2dlbnB0ci5jCmluZGV4IDUyNjE1NjI4ZTNmLi45MGI3MWViYzAxNiAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRy
LmMKQEAgLTExNTYsNyArMTE1Niw4IEBAIHZvaWQgZ2VuX2ZyYW1lY2hlY2soRGlzYXNDb250ZXh0
ICpjdHgsIFRDR3ZfaTMyIGFkZHIsIFRDR3ZfaTMyIGVhKQogICAgIFRDR0xhYmVsICpvayA9IGdl
bl9uZXdfbGFiZWwoKTsKICAgICB0Y2dfZ2VuX2JyY29uZF9pMzIoVENHX0NPTkRfR0VVLCBhZGRy
LCBoZXhfZ3ByW0hFWF9SRUdfRlJBTUVMSU1JVF0sIG9rKTsKICAgICBnZW5faGVscGVyX3JhaXNl
X3N0YWNrX292ZXJmbG93KHRjZ19lbnYsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHRjZ19jb25zdGFudF9pMzIoY3R4LT5pbnNuLT5zbG90KSwgZWEpOworICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0YW50X2kzMihjdHgtPmluc24tPnNsb3Qp
LCBlYSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF9p
MzIoY3R4LT5wa3QucGMpKTsKICAgICBnZW5fc2V0X2xhYmVsKG9rKTsKICNlbmRpZgogfQpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYwppbmRleCA3MWIyN2VmMDdmMS4uY2RiNzMxMTYwZWIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBA
IC0xNjYwLDcgKzE2NjAsNyBAQCB2b2lkIEhFTFBFUih2d2hpc3QxMjhxbSkoQ1BVSGV4YWdvblN0
YXRlICplbnYsIGludDMyX3QgdWlWKQogCiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKIHZvaWQg
SEVMUEVSKHJhaXNlX3N0YWNrX292ZXJmbG93KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3Qgc2xvdCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBiYWR2
YSkKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBiYWR2YSwgdWlu
dDMyX3QgcGMpCiB7CiAgICAgLyoKICAgICAgKiBQZXIgc2VjdGlvbiA3LjMuMSBvZiB0aGUgVjY3
IFByb2dyYW1tZXIncyBSZWZlcmVuY2UsCkBAIC0xNjc3LDYgKzE2NzcsOCBAQCB2b2lkIEhFTFBF
UihyYWlzZV9zdGFja19vdmVyZmxvdykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNs
b3QsCiAgICAgY3MgPSBlbnZfY3B1KGVudik7CiAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IEhF
WF9FVkVOVF9QUkVDSVNFOwogICAgIGVudi0+Y2F1c2VfY29kZSA9IEhFWF9DQVVTRV9TVEFDS19M
SU1JVDsKKyAgICAvKiBUaGUgUEMgcmVnaXN0ZXIgaXMgbm90IGtlcHQgY3VycmVudCwgRUxSIGlz
IHRoZSBmYXVsdGluZyBwYWNrZXQgKi8KKyAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IHBjOwog
CiAgICAgaWYgKHNsb3QgPT0gMCkgewogICAgICAgICBlbnYtPnRfc3JlZ1tIRVhfU1JFR19CQURW
QTBdID0gYmFkdmE7CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9z
eXN0ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5Cmlu
ZGV4IDYwNjU2NzIzMGI5Li5mOTk3NTYzYmFjYSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25h
bC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L3Rlc3Rfc3lzdGVzdHMucHkKQEAgLTg3LDYgKzg3LDExIEBAIGRlZiB0ZXN0X2Zsb2F0X2V4Y3Ao
c2VsZik6CiAgICAgICAgIHRoYXQgY2F1c2VkIHRoZW0gY29tbWl0cy4iIiIKICAgICAgICAgc2Vs
Zi5ydW5fZXhpdF96ZXJvKCJmbG9hdF9leGNwIikKIAorICAgIGRlZiB0ZXN0X2ZyYW1lbGltaXQo
c2VsZik6CisgICAgICAgICIiImFsbG9jZnJhbWUgcGFzdCBGUkFNRUxJTUlUIGluIHVzZXIgbW9k
ZSByYWlzZXMgdGhlIHN0YWNrIGxpbWl0CisgICAgICAgIGV4Y2VwdGlvbiBhdCB0aGUgYWxsb2Nm
cmFtZSBwYWNrZXQuIiIiCisgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygiZnJhbWVsaW1pdCIp
CisKICAgICBkZWYgdGVzdF9hY2Nlc3Moc2VsZik6CiAgICAgICAgICIiImFjY2VzcyBjaGVja3Mg
Ul9PS3xXX09LIG9uIF90ZXN0ZmlsZV9hY2Nlc3MuIiIiCiAgICAgICAgIHRlc3RmaWxlID0gc2Vs
Zi5zY3JhdGNoX2ZpbGUoIl90ZXN0ZmlsZV9hY2Nlc3MiKQotLSAKMi4zNC4xCgo=

