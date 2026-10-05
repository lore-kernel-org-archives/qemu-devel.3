Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AFBCA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDocw-00025G-61; Mon, 05 Oct 2026 15:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDocq-00024h-U0
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:45:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDocp-0001wf-8K
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:45:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HKcSE3579342
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 19:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7i1wY7WMWbor+NloZUs6YQ8L1YvKKd7Ft2m0eJe0Cl4=; b=RytboTiLY0nd6cHy
 r8VRM02BJAn6ggzRs2UwY5l3tB/3PjvPHTqnsUhkaFDggnvy3mtpN4cEHNwhcpQO
 QEGZcMLS50lcfbr/QqA6lKxGj9FvsV6qOUWLA/urtO/PIuTPlay9G1cCl3E5cri7
 M9TVy8znhOE6/9/aSo/b35hFNZFmMruRRcaW0VlPOSWX3HvC4supWGLudUbmYQUj
 sBHmrlHwn62rR4ZGUFPUcrD7q0EQoYPsDy7gPcVXKS3ycPiY8n7qQSKRz/ZT6JpO
 ai2aYOxOYJJoq66M20NNeYliQ1jE74FVAtxiZhm+9X/gaMuRFQl19E1OX3tYIobR
 /4xtIA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cuu1f76-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 19:45:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso6351665eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791229525; x=1791834325; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7i1wY7WMWbor+NloZUs6YQ8L1YvKKd7Ft2m0eJe0Cl4=;
 b=IpzqIkIYx10NSHtc54kz+ZMdnMHCPeiJgY3YM2zQO9p4c90KEi/+bkWWpkvJ1+JZb3
 ZczzqIo0uB1K+Jg0tv3PAK6PfYwz5rNzu8fM0LoyFidrcNl4Pv9ZMBlaPpRUMf2ihyhv
 UqCqRQgsGE9IJzb20ngazPCRNxpWfLDKwDkX0VRBAOIJtxQDDnNG42rJFGsJGicJu2nV
 C03nYiCzyoLDEDrNMsyFuDD5b05moIiEYpdvPttxGwO8n5JDnyG/MtpGmuRnDu7Mz4Y0
 P8M8EUT0wQkY9zixAKcvS0w/sMQJUhLkVvG12JBOMv7ELH+OvSIXUFdj+hIgXCWYSMcU
 OtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229525; x=1791834325;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7i1wY7WMWbor+NloZUs6YQ8L1YvKKd7Ft2m0eJe0Cl4=;
 b=2i2K5aCP0o/E7+2qs5+am1Y4eYwUxzQlIIDugmedwRjATmjAJyWt3kcgUDEm27H4h/
 wgE3SJY/wfYRggzG21RBnUx+p/0HiT7rNV5/cjzbpUHhMRqJMuinflyjD39OWrG/GaKC
 UnjDnEIxzWxybsTN3sMeqnCebaoHDLPNIjc3dva6pno+T8akwUdpzPa5bjE/HPO+tmW2
 ikCt4q/WHMjQcXIAdm3hUbNXlcuCTghAA5csk7Q7JGo5gMaIheWFBn/lxLcl83WSZt8h
 bgsvdHgUOuesmvoXlqIA5K/3SJibphrR4P0w253KJXdz4D/V4eV1IBWVW63MyGyckX+D
 ElWQ==
X-Gm-Message-State: AFuF++lYsjk6cvkjABWYl80I9nSp7diQdFNEXsdYMmTgvtYNQtFZIwSN
 S+6feTUCdIf8f/RRPrIosVMHJTtRfWzww7CEj+63K/o7Rh1yYAnVJL2s0JbnRaYSgurNQq/0bSB
 jGACEwAihX5a+ovcFcwn4DHM6hRMSSjs0j5pFWtBvRklk50EBEJS6Qs3rtYlIqQhKOg==
X-Gm-Gg: AYBFou37/NOWmXdIxjq1wlygLT0JPFycVwZt9v6uMgGz0ptmsVdtsw7eDbASn00+GgE
 TYK2XECqHOnsvS8U6s7U+yPO49tYNG3c4TMwGHftZ7gwV7CcR7za+GP+QeQJlN3Y+rydyMfDvNd
 QfkypjKWbTlaGdgW7XzrauzB851/2puzkgvgkWS2ZrG0y96CSXqcMubwj36qo8JtCbiPSfdlKlx
 kFLArwG5IG8fk9C8NVLDjmFaeP6Zn/bW7CwPEGYmrmjXPiZD7j/RouphruhM0sZXmkP3EanKBjh
 3PtcxSIRqvju9L71UEOGFcHG+mCN9velNM3qlZVm1KgI8b3hfjOpvoUx1qExmvME1bf9hkAVdp1
 mI2lrSPi/XCzwJhVRp385DsRwhYkFA4frDpoS6DlA/kEdu50=
X-Received: by 2002:a05:7300:d948:b0:351:2c96:1bfa with SMTP id
 5a478bee46e88-3512c961e58mr5065127eec.3.1791229525220; 
 Mon, 05 Oct 2026 12:45:25 -0700 (PDT)
X-Received: by 2002:a05:7300:d948:b0:351:2c96:1bfa with SMTP id
 5a478bee46e88-3512c961e58mr5065102eec.3.1791229524592; 
 Mon, 05 Oct 2026 12:45:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351468b2920sm541742eec.4.2026.10.05.12.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 12:45:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/2] target/hexagon: implement nmi
Date: Mon,  5 Oct 2026 12:45:19 -0700
Message-Id: <20261005194519.2945862-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
References: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX3eyo8Yc77GVE
 jC4gOAjYtuAOo4MompKOJp/FTwoSe0smKGRmJrNbDVWCVOGFvcudNuySR6V5NwNyyM64ya7RfAK
 Xeo0EMurAi8T9qFKjbjbc28iT8o8bSY=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ac3fe55 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=AJ2bX_oiER2d6UdsYA0A:9 a=Am1coFdZJ3nYTNsW:21
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 7MNEt5AVBAYg0HrFq7B937kEO8hceR_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX/qNPVwlhM98f
 rxl8UdrjhP/NwspoLeL7OAsbGfGp+e0YOT4/lhMsCCVQcGBWa7D9OhQxkrNbD2lsMZfyHLlfyHa
 C3JxU++qcFb1qssfvjIlps2SRhQifN61UyXlZjKEZ6pTWj0qtp77gRqX0iUm+VMIb9qHyQoMpqy
 DSTY4eOS4fridz1A/ApIJkd8mtBssAPEAFruH88INGvVPZqglpGkFhhffbHkpzpwZwRvbRysd61
 paWxnQE57BNH5KKXoS/MMX7oFkjmVrK7FxqcWxua/MTbpfbGtC+DZNfyyjkpT8qyei1f99KFDSn
 FIgJOXG5hGBewYFTofONpseMranURDWToOWo02Zh6RXUaruFef3Yr0TF++9c+qre6OQAuTkIRQh
 C7yYIHFLJkfjKIclg8eSvqbxgNpgVOHAlb77HPxJaDLCdG9hpFUJ1xsVePgCqxfWVJO9SoKv3LP
 lu4RpMLjaqLLAMVQVBw==
X-Proofpoint-GUID: 7MNEt5AVBAYg0HrFq7B937kEO8hceR_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050077
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

WTRfbm1pIHdhcyBhIG5vLW9wLCBsZXQncyBmaWxsIGluIHRoZSBtaXNzaW5nIGltcGxlbWVudGF0
aW9uLgoKV2UnbGwgcmFpc2UgQ1BVX0lOVEVSUlVQVF9OTUkgb24gZWFjaCBydW5uaW5nIHRocmVh
ZCBpbiB0aGUgbWFzay4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgfCAgMSArCiB0
YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggfCAgMSArCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFj
cm9zLmggfCAgMyArLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICB8IDExICsrKysrKysr
KystCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCAxNyArKysrKysrKysrKysrKysrKwog
NSBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXgg
ZGY0YzAxODIyNDcuLjc3M2ZhNDVjNTJhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
aAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTksNiArNTksNyBAQCB0eXBlZGVmIHN0
cnVjdCBIZXhhZ29uSFZYQ29udGV4dFN0YXRlIEhleGFnb25IVlhDb250ZXh0U3RhdGU7CiAjZGVm
aW5lIENQVV9JTlRFUlJVUFRfU1dJICAgICAgQ1BVX0lOVEVSUlVQVF9UR1RfSU5UXzAKICNkZWZp
bmUgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sgQ1BVX0lOVEVSUlVQVF9UR1RfSU5UXzEKICNkZWZp
bmUgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLIENQVV9JTlRFUlJVUFRfVEdUX0lOVF8yCisjZGVm
aW5lIENQVV9JTlRFUlJVUFRfTk1JIENQVV9JTlRFUlJVUFRfVEdUX0VYVF8wCiAKICNkZWZpbmUg
SEVYX0NQVV9NT0RFX1VTRVIgICAgMQogI2RlZmluZSBIRVhfQ1BVX01PREVfR1VFU1QgICAyCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggYi90YXJnZXQvaGV4YWdvbi9j
cHVfaGVscGVyLmgKaW5kZXggYWZiNGRmNTlmODAuLjk1YThmNjU4N2I2IDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBl
ci5oCkBAIC0yMiw2ICsyMiw3IEBAIHZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhleGFnb25TdGF0
ZSAqZW52KTsKIHZvaWQgaGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBjYXVzZSk7CiB2b2lkIGhleGFnb25fc3RhcnRfdGhyZWFkcyhDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDMyX3QgbWFzayk7CiB2b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BV
SGV4YWdvblN0YXRlICplbnYpOwordm9pZCBoZXhhZ29uX25taShDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdWludDMyX3QgdGhyZWFkX21hc2spOwogdm9pZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKTsKIHVpbnQ2NF90IGhleGFnb25fZ2V0
X3N5c19wY3ljbGVfY291bnQoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogdWludDMyX3QgaGV4YWdv
bl9nZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52KTsKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL3N5c19t
YWNyb3MuaAppbmRleCBhNWI5YjdmMjU5Mi4uMWE0NTEzZDY2ZjggMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL3N5c19tYWNyb3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgK
QEAgLTI1Myw3ICsyNTMsNiBAQAogCiAjZGVmaW5lIE5VTV9UTEJfUkVHUyh4KSAoaGV4YWdvbl90
bGJfZ2V0X251bV9lbnRyaWVzKGVudl9hcmNoY3B1KGVudiktPnRsYikpCiAKLS8qIE5NSSByb3V0
aW5nIG5vdCB5ZXQgaW1wbGVtZW50ZWQ7IFk0X25taSBpcyBhIG5vLW9wIGZvciBub3cgKi8KLSNk
ZWZpbmUgZkRPX05NSShUSFJFQURfTUFTSykgZG8geyB9IHdoaWxlICgwKQorI2RlZmluZSBmRE9f
Tk1JKFRIUkVBRF9NQVNLKSBoZXhhZ29uX25taShlbnYsIFRIUkVBRF9NQVNLKQogCiAjZW5kaWYK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMK
aW5kZXggMWY3ZDhhOGRmNzAuLmJhMDVjYmEyYmU3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzkzLDcgKzM5Myw4IEBAIHN0
YXRpYyBib29sIGhleGFnb25fY3B1X2hhc193b3JrKENQVVN0YXRlICpjcykKIAogICAgIHJldHVy
biBoZXhhZ29uX3RocmVhZF9pc19lbmFibGVkKGVudikgJiYKICAgICAgICAgKGNzLT5pbnRlcnJ1
cHRfcmVxdWVzdCAmIChDUFVfSU5URVJSVVBUX0hBUkQgfCBDUFVfSU5URVJSVVBUX1NXSQotICAg
ICAgICAgICAgfCBDUFVfSU5URVJSVVBUX0swX1VOTE9DSyB8IENQVV9JTlRFUlJVUFRfVExCX1VO
TE9DSykpOworICAgICAgICAgICAgfCBDUFVfSU5URVJSVVBUX0swX1VOTE9DSyB8IENQVV9JTlRF
UlJVUFRfVExCX1VOTE9DSworICAgICAgICAgICAgfCBDUFVfSU5URVJSVVBUX05NSSkpOwogfQog
I2VuZGlmCiAKQEAgLTc1NCw2ICs3NTUsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBTeXNlbXVD
UFVPcHMgaGV4YWdvbl9zeXNlbXVfb3BzID0gewogc3RhdGljIGJvb2wgaGV4YWdvbl9jcHVfZXhl
Y19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJydXB0X3JlcXVlc3QpCiB7CiAgICAg
Q1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKKyAgICBpZiAoaW50ZXJydXB0X3Jl
cXVlc3QgJiBDUFVfSU5URVJSVVBUX05NSSkgeworICAgICAgICBjcHVfcmVzZXRfaW50ZXJydXB0
KGNzLCBDUFVfSU5URVJSVVBUX05NSSk7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsKKyAg
ICAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IEhFWF9FVkVOVF9JTVBSRUNJU0U7CisgICAgICAg
IGVudi0+Y2F1c2VfY29kZSA9IEhFWF9DQVVTRV9JTVBSRUNJU0VfTk1JOworICAgICAgICBoZXhh
Z29uX2NwdV9kb19pbnRlcnJ1cHQoY3MpOworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CiAg
ICAgaWYgKGludGVycnVwdF9yZXF1ZXN0ICYgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKSB7CiAg
ICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsKICAgICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChj
cywgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwppbmRleCBjZjA3NjJm
ZjA1Zi4uYWY1MTY3ZTRlZWIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKQEAgLTU0Nyw2ICs1NDcsMjMgQEAg
dm9pZCBoZXhhZ29uX3N0b3BfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgIH0KIH0K
IAordm9pZCBoZXhhZ29uX25taShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGhyZWFk
X21hc2spCit7CisgICAgQ1BVU3RhdGUgKmNzOworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKwor
ICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIENQVUhleGFnb25TdGF0ZSAqdGhyZWFkID0g
Y3B1X2Vudihjcyk7CisKKyAgICAgICAgaWYgKCEodGhyZWFkX21hc2sgJiAoMXUgPDwgdGhyZWFk
LT50aHJlYWRJZCkpIHx8CisgICAgICAgICAgICBnZXRfZXhlX21vZGUodGhyZWFkKSA9PSBIRVhf
RVhFX01PREVfT0ZGKSB7CisgICAgICAgICAgICBjb250aW51ZTsKKyAgICAgICAgfQorICAgICAg
ICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX05NSSk7CisgICAgfQorfQorCiBzdGF0
aWMgaW50IHN5c19pbl9tb25pdG9yX21vZGVfc3NyKHVpbnQzMl90IHNzcikKIHsKICAgICBpZiAo
KEdFVF9TU1JfRklFTEQoU1NSX0VYLCBzc3IpICE9IDApIHx8Ci0tIAoyLjM0LjEKCg==

