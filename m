Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IOrSSVOR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d1pGjXVe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXsh-00026L-41; Mon, 26 Oct 2026 23:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXse-00025e-Ot
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXsc-0008Hv-OE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F6nO512430
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=; b=IOrSSVORvmGHx0Lh
 tBvQ9S8kVJHIeKmN4VecOsMgjA+9ScazLMeQEj0QyJwzPyzwehfDMazNbWM0qMyM
 WluYC3FchlVTahpmLFezyPU6fH/By0ywkW+wL39dBUgdWxgspCI/x15fut5nn6pP
 p3XYSKisoHqvN2GQzzVOPk6mzlpBhKt0tmSFiRu4fOly+mnNh+xv98FlqMLdP3wy
 ey5JYjQPCBXxKAawKIJpkgc6CF66UBbuydVgTGqyEbwtQ7315wm0pUq1AQ1xdQ3Y
 t1+6oYINPSGMAQv5pXfPwuC9z5qvOl0j5SsqbNF8qrmF+TTy0VLBcl3MLtndTixh
 sb9GZw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cpbm8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6793913eec.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071780; x=1793676580; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=;
 b=d1pGjXVeG2w/Hvtw0WEmOB9A+kZ/CdtvtV24Dn/hAmefgjFqfrrxlcpl8aBGitXzPA
 ekaDZObx7/0pEAvENpfOA+G/QX4ZJwCzKr1cX6cmQRLCdffyeVA0kfnDggS78RRscX5T
 jRWITWa7bwDavM0d7zXnvvjmdgIVV0N5SCuvoSKIF6h6XLFoiPkpVGgO1479VqPT9v1J
 n9VN3TYLxqRFPovuKa2AtWVOVQVMM80J1WqmSEeR+9sUWFOYw2pXKcEu4IvF/WQ8jD0N
 MPx7eAc4rAJDPR+NlYCarAQ1oat9k5dtPwgf/cVKMRvifmel3wVyg7OWRAuVVl4sdVLF
 +7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071780; x=1793676580;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tLSeGqwEqa8SPtaWdHqwM6yl/1+LAR8zd04FtV9ZoZo=;
 b=WX4lPW+NCtCDW+x9A1+JZrhDAZkKiM+H2t5O9KjKfpGqvvFiWC8PMejbKdL0LZhmXD
 HLEKq5QgKj7q1W0WepzXe3cyoK0XJ88M0MX0HJdIw+irRJMXhcax0D4joRtUkiwy2mxi
 6GVrumcwERS6a0KF51IO/Xeuk7bXJYpxC084zD32OYRPFxz6PViv1CjHqrMl8+0Ajdbu
 UnqMhv8rkSuiyqqctsy7ghZSJtNjrR/gRA55mJQbcKcqKsCiGipII0nHEw2m8TOyt3v6
 JlnY0+AZoZTpsKKHWqbDDF8fUOeecjX4Q+UWb7OMl1qFHw1SCWBRrt9RUWyM5rjrIJ3c
 SvfQ==
X-Gm-Message-State: AFq9FYLaefRO7QlhEsOdAVcylu8rEAapRn7nGQX9VT0QRp0MGFeu/Rw+
 u5PhwtUN9TcLRi6U9TH34sJSgFUbSIi0mH4kcF/+66gP5xOy+37bh8Do3R8KZcZvWVaXKosNlX0
 DphYHLpe4/ljMdaunVyxKw9qJcG9HQRWjT9XgpTpkWxzkSjfJRCYfDjtXgHd7yWjpGA==
X-Gm-Gg: AYBFou09RxW41pEBDzN6AnCPTA1dowr6g8GStNmoDZzRl0o2FkTLRPAtheS4Hvrfmzu
 mC4JTErDDePybVTlCxVPn0ir8Oexd9iH7tY9i86tuzl9zgzxoobTk3ND+/Khc8OMZjREi3tE6lh
 BV4lMLKJfb+YGXFNLm0rbsoaDT3NF/41yl4Gv4+nY8XdzkH7LnpLoxe2e5LJm6zsATOoNXwrV9f
 unMjlpNn35HoMnaN2/mA5A0RUwcfn5e3a7HY0fsltJRwhey//aNyRLwUjhzcJF9CN3lfHzB211G
 lozCv41OIuuj5a9VTAJErVbvJmS5YGQ+ExQjypaYxMATGjMYgAKD25GV/mZLd/EI2zw72QJwU2K
 DOkxv5nlHzL0si9i6QECSrMbMNGzHWvPzlgV/OHKjtWOEOS0=
X-Received: by 2002:a05:7022:238f:b0:16d:dd5c:4261 with SMTP id
 a92af1059eb24-1993f2040bdmr18569330c88.46.1793071780358; 
 Mon, 26 Oct 2026 20:29:40 -0700 (PDT)
X-Received: by 2002:a05:7022:238f:b0:16d:dd5c:4261 with SMTP id
 a92af1059eb24-1993f2040bdmr18569289c88.46.1793071779715; 
 Mon, 26 Oct 2026 20:29:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:29:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 02/41] target/hexagon: fix allocframe FRAMEKEY scrambling
Date: Mon, 26 Oct 2026 20:28:48 -0700
Message-Id: <20261027032927.3055166-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX6Twpyo96a/pg
 1tQxn6WXPS6W+JYs3d+3LttriMOEs20rAubdOSmqjN5TlSBPCqugQ0EnLm6MWzRl3Kv0lNvOYQY
 xYR4GNlY8MztYWYQh2I4RAIyxdNYEnccU4d/vz7lkn4TQK/8t8q5Pbyio8uQVYGg2Pu7DocaWxI
 GDYzvlTNtqV9diP3W7zTrbFvGRilaJN46H1PZcmGGlB0GawPNn+jKHjURsZ0rVIWKI8bgLJKpDr
 7zjR18qlpIHvSGgwELhcHRx5ddXUVjkW+Ri9KFNfBC3Kw0LkYuD/9XelAkT0AsIHGDB/iH/Gpg9
 uMX3NblKa2Gq6qwcM6X7iLTMPSglIHiSsGOpMiKw2zsehk0ljCb74gMDfMHDp+ZSI7fG7KS1amP
 OMkXYnC/uouG/BtVbRHF7WUhQhZOrgVJhECbILGrM9uP6JTCb6FrQ705N3KAnC00EsVBdetEJOv
 150IABQERea5pjfxhtA==
X-Proofpoint-GUID: wO95v6ZTsK_HLaWoQgmUXSFmDQNMdWfL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfXxOTrCL79+3my
 A2tEEt3vKPB98EuNiUxNemA0mmurWtKzrGuTTvEHVreRPqqi02t/RWdmO/MDIrQ42ytkQb6qkyf
 OS83znJOGNVGVIf7ZnlUDtEbf1hkD9U=
X-Proofpoint-ORIG-GUID: wO95v6ZTsK_HLaWoQgmUXSFmDQNMdWfL
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6ae01aa5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aMyhTJ8ZNNJ-BQydHqwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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

VGhlIGFyY2hpdGVjdHVyZSBzY3JhbWJsZXMgb25seSB0aGUgTFIgd29yZCBvZiB0aGUge0ZQLCBM
Un0gZnJhbWUgdGhhdAphbGxvY2ZyYW1lIHN0b3Jlcy4gIFdpdGggdGhlIGlkZWYgcGFyc2VyIGVu
YWJsZWQsIGZGUkFNRV9TQ1JBTUJMRSBidWlsdAp0aGUgWE9SIGtleSB3aXRoIEZSQU1FS0VZIGlu
IGJvdGggaGFsdmVzIG9mIHRoZSA2NC1iaXQgdmFsdWUsIHNvIHRoZQpzdG9yZWQgRlAgd2FzIHNj
cmFtYmxlZCBhcyB3ZWxsLgoKZGVhbGxvY2ZyYW1lIGlzIGFsc28gcGFyc2VyLWdlbmVyYXRlZCBh
bmQgYXBwbGllcyB0aGUgc2FtZSBpbmNvcnJlY3QKdHJhbnNmb3JtIGEgc2Vjb25kIHRpbWUsIHdo
aWNoIG1hc2tzIHRoZSBlcnJvci4gIGRlYWxsb2NfcmV0dXJuIHVzZXMgdGhlCmhhbmQtd3JpdHRl
biBUQ0cgaW1wbGVtZW50YXRpb24gdGhhdCBjb3JyZWN0bHkgZGVzY3JhbWJsZXMgb25seSBMUiwg
c28KaXQgbGVhdmVzIEZQIGNvcnJ1cHQgd2hlbiByZXR1cm5pbmcgZnJvbSBhIGZyYW1lIGFsbG9j
YXRlZCBieSB0aGUgcGFyc2VyLgoKQWRkIGEgcmVncmVzc2lvbiB0ZXN0IHRoYXQgc2V0cyBhIG5v
bnplcm8gRlJBTUVLRVksIGFsbG9jYXRlcyBhIGZyYW1lLAphbmQgcmV0dXJucyB0aHJvdWdoIGRl
YWxsb2NfcmV0dXJuIHRvIHZhbGlkYXRlIHRoZSByZXN0b3JlZCBGUC4KClVuY292ZXJlZCBieSB0
ZXN0aW5nIHNvbWUgYm9vdCBpbWFnZXMgdXNpbmcgUXVSVC4KClJldmlld2VkLWJ5OiBNYXJjbyBM
aWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyB8ICAyICstCiB0ZXN0cy90Y2cvaGV4YWdvbi9m
cmFtZWtleS5jICAgICAgICAgICAgICAgIHwgNTQgKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0
cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgIDEgKwogMyBmaWxlcyBj
aGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMgYi90YXJnZXQvaGV4YWdvbi9pZGVmLXBh
cnNlci9wYXJzZXItaGVscGVycy5jCmluZGV4IDQ5Y2MxMWZkZGQ4Li4xNDg0MGQ5ODczNyAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jCkBAIC0xOTg5LDcg
KzE5ODksNyBAQCBIZXhWYWx1ZSBnZW5fcnZhbHVlX2ZzY3IoQ29udGV4dCAqYywgWVlMVFlQRSAq
bG9jcCwgSGV4VmFsdWUgKnZhbHVlKQogICAgICp2YWx1ZSA9IGdlbl9ydmFsdWVfZXh0ZW5kKGMs
IGxvY3AsIHZhbHVlKTsKICAgICBPVVQoYywgbG9jcCwgImdlbl9yZWFkX3JlZygiLCAmZnJhbWVf
a2V5LCAiLCBIRVhfUkVHX0ZSQU1FS0VZKTtcbiIpOwogICAgIE9VVChjLCBsb2NwLCAidGNnX2dl
bl9jb25jYXRfaTMyX2k2NCgiLAotICAgICAgICAma2V5LCAiLCAiLCAmZnJhbWVfa2V5LCAiLCAi
LCAmZnJhbWVfa2V5LCAiKTtcbiIpOworICAgICAgICAma2V5LCAiLCB0Y2dfY29uc3RhbnRfdGwo
MCksICIsICZmcmFtZV9rZXksICIpO1xuIik7CiAgICAgT1VUKGMsIGxvY3AsICJ0Y2dfZ2VuX3hv
cl9pNjQoIiwgJnJlcywgIiwgIiwgdmFsdWUsICIsICIsICZrZXksICIpO1xuIik7CiAgICAgcmV0
dXJuIHJlczsKIH0KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMgYi90
ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMDAwLi4xNGM3ZmNiYzY1NAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy9oZXhh
Z29uL2ZyYW1la2V5LmMKQEAgLTAsMCArMSw1NCBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykgUXVh
bGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAq
ICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKyNpbmNs
dWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPHN0ZGludC5oPgorCitpbnQgZXJyOworCisjaW5jbHVk
ZSAiaGV4X3Rlc3QuaCIKKworLyoKKyAqIGFsbG9jZnJhbWUgcHVzaGVzIHtMUiwgRlB9LCBzY3Jh
bWJsaW5nIExSIHdpdGggRlJBTUVLRVkuICBSZXR1cm4gdGhyb3VnaAorICogZGVhbGxvY19yZXR1
cm4gYW5kIHJlcG9ydCB0aGUgRlAgdGhhdCBpdCByZXN0b3Jlcy4KKyAqLworc3RhdGljIGlubGlu
ZSB1aW50MzJfdCBmcmFtZV9yb3VuZHRyaXAodWludDMyX3Qga2V5LCB1aW50MzJfdCBmcCkKK3sK
KyAgICB1aW50MzJfdCBmcF9iYWNrLCBzYXZlZF9mcCwgc2F2ZWRfbHI7CisKKyAgICBhc20gdm9s
YXRpbGUoIiVbc2F2ZWRfZnBdID0gcjMwXG5cdCIKKyAgICAgICAgICAgICAgICAgIiVbc2F2ZWRf
bHJdID0gcjMxXG5cdCIKKyAgICAgICAgICAgICAgICAgImZyYW1la2V5ID0gJVtrZXldXG5cdCIK
KyAgICAgICAgICAgICAgICAgInIzMCA9ICVbZnBdXG5cdCIKKyAgICAgICAgICAgICAgICAgInIz
MSA9ICMjMWZcblx0IgorICAgICAgICAgICAgICAgICAiYWxsb2NmcmFtZSgjMClcblx0IgorICAg
ICAgICAgICAgICAgICAicjMxID0gIzBcblx0IgorICAgICAgICAgICAgICAgICAiZGVhbGxvY19y
ZXR1cm5cblx0IgorICAgICAgICAgICAgICAgICAiMTpcblx0IgorICAgICAgICAgICAgICAgICAi
JVtmcF9iYWNrXSA9IHIzMFxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFtZWtleSA9ICVbemVy
b11cblx0IgorICAgICAgICAgICAgICAgICAicjMwID0gJVtzYXZlZF9mcF1cblx0IgorICAgICAg
ICAgICAgICAgICAicjMxID0gJVtzYXZlZF9scl1cbiIKKyAgICAgICAgICAgICAgICAgOiBbZnBf
YmFja10gIj0mciIoZnBfYmFjayksCisgICAgICAgICAgICAgICAgICAgW3NhdmVkX2ZwXSAiPSZy
IihzYXZlZF9mcCksIFtzYXZlZF9scl0gIj0mciIoc2F2ZWRfbHIpCisgICAgICAgICAgICAgICAg
IDogW2tleV0gInIiKGtleSksIFtmcF0gInIiKGZwKSwgW3plcm9dICJyIigwKQorICAgICAgICAg
ICAgICAgICA6ICJtZW1vcnkiLCAiZnJhbWVrZXkiKTsKKyAgICByZXR1cm4gZnBfYmFjazsKK30K
Kworc3RhdGljIHZvaWQgY2hlY2tfZnJhbWUodWludDMyX3Qga2V5LCB1aW50MzJfdCBmcCkKK3sK
KyAgICBjaGVjazMyKGZyYW1lX3JvdW5kdHJpcChrZXksIGZwKSwgZnApOworfQorCitpbnQgbWFp
bigpCit7CisgICAgY2hlY2tfZnJhbWUoMCwgMHgxMjM0ZmZmMCk7CisgICAgY2hlY2tfZnJhbWUo
MHhmMjFmMjBhMCwgMHgxMjM0ZmZmMCk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNT
Iik7CisgICAgcmV0dXJuIGVycjsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21l
c29uLmJ1aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggYTZhY2U0Yzc3
YzIuLjBmZDYyY2U3ZTRjIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWls
ZAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNjgsNiArNjgsNyBAQCB0
ZXN0cyArPSB7CiAgICdvdmVyZmxvdy5jJzogeydjZmxhZ3MnOiBjZmxhZ3MsICdleGVfbmFtZSc6
ICdoZXgtb3ZlcmZsb3cnfSwKICAgJ3ByZWdfYWxpYXMuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwK
ICAgJ2R1YWxfc3RvcmVzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCisgICdmcmFtZWtleS5jJzog
eydjZmxhZ3MnOiBjZmxhZ3N9LAogICAnbXVsdGlfcmVzdWx0LmMnOiB7J2NmbGFncyc6IGNmbGFn
c30sCiAgICdtZW1fbm9zaHVmLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdtZW1fbm9zaHVm
X2V4Y2VwdGlvbi5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAotLSAKMi4zNC4xCgo=

