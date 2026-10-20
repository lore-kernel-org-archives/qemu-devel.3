Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DC3606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6LqXVd9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IQbtB1o2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIz1K-0008GR-Bf; Mon, 19 Oct 2026 21:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIz1G-0008Fx-Oy
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 21:52:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIz1D-0002pg-LM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 21:52:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K1DoeG744225
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 01:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=t/GUMiao7kD7HhZtVSrMfa
 ekGjAneUfs22Gw1ryYd9s=; b=p6LqXVd91ThQH8jvz+kiAfhKwDfTLbTUH7KfBa
 wSUJcN9ojeWhSCpQAbn5/y+jnJohDg69x+sanY0JqIfHwmTwagqPjc7GvLkPjWaS
 NpaPlAukEakM7Th+0vb9yEbIwI4LYX6ASgpq2YAd+zxbKKnX4Cpzw3bQl3RdC5In
 OdheuVNXohXwYVba1TjnDOj2k7MTOVYBkBy+0eoxM+ro3eD5ac5OqcCXdIjhAuxr
 aTQWjyqQK6mHq4s3j3WGxHFeiMn9idMX6LO2KMVYUM307r+3Cazjq3tCUzIRdpze
 +dqAkfzb0tkm3XtdGyF4BJr3NjLpcf17LKLXoXCxeSDzpyhg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pge6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 01:51:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3662e7a9299so805403eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 18:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792461116; x=1793065916; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t/GUMiao7kD7HhZtVSrMfaekGjAneUfs22Gw1ryYd9s=;
 b=IQbtB1o2V0g4/CIPMHtV2DO9pn0+zoVFZOKno6Uz0JxFcDA8ZBwFo25um20C8ECJlC
 CRv1SoCWolchfyG+1I1+FM7+H5Aa1JB+sh4wKfNd5Crolx3Dtj3UF/+Zy7X/Gw89kc/P
 hLE002DCMdY/sy4ufG0ugcpjBq6Qm6K34cXcDjT/r2CiDbOvJueyxUjl7VhBZUrJ8ovu
 3sp1PMsOrZr7AHkmitTgg+cuEvWlAjzX1WvcrUvOxH/L2EqxV4kkhao3pogyxEEo7Q+x
 ajf00fG7c8fIZCEa4TY1IczDS3h7V6a6/73nIyui2zV2WM66aZCUNgXSrEamrzbSggph
 wwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792461116; x=1793065916;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t/GUMiao7kD7HhZtVSrMfaekGjAneUfs22Gw1ryYd9s=;
 b=rvkUQlfLv7vvDBoX3sk4Lr1TgIv7eNSb3JIrIsKygxRreahBnUpk9Cy852i3bKZO/r
 k9rKokpKPJFz6+L5uHK2DdTTM36hoLFmFPuJU6Y7WdCGJreiN7j0+XxOZOAPSJ6oWDqJ
 DjHv8k+SeQ5+hQi7BFCBN6Z0KhDJa/sP/AsOKqRCZ1kES5c/1qFy3eszE9EHPVjoDpHR
 agQORKSmuknBgQSqUl5j8biglTwBi1Az7b0R37kH9mt67Xg+o13IxS63h2Vsd9nC3uKi
 w/NqToKL7nbWXwGCLL/iGvc0+ZORoAoiAriKNXc4ISz59P/hRsZtSZMTL+p/I2m3WJR1
 qN0w==
X-Gm-Message-State: AFq9FYK2l9VeZCu3u4oq5SC+tLFSWlWn1rcIHicPTYKZcSrH2mVIGrUy
 mak5UjcNbe4sNt4ZojnCb/5dnxbYW6JKixPBq851GckpkoyK3EfccjCrjp+vuCFiBvWCHhGqAAB
 x2gMNCZxvT3AAMWVsjuaZPaFpOWIHNT5mL/b38ih/A3KQEH03D2waNV6CHQh3SSVUHQ==
X-Gm-Gg: AYBFou19J/6N+gg+rLM+4g1mI+0JYp+mFQBSX2uaxVpmmkOYX+Suk8CDQggs3n9k1Hx
 pn5RxNued9CzLC08xFTAz+SxVacyjfbDKdBsHPP6YowxsAr49zxiuCcf8UDD4hCbhGZEaEJkfHh
 dukocazNCg66T9ykdxcyUUcgcVX7eAIZ9F2u0GJk8vtPsN9905tNu7W2w1YgWEGFvctDud1A9pG
 7buiMJ4+I+LMw4nHvjU+4sDFcxyAdrP/kffptzFHdsfc1qutLbRcOcNlmta6YobUOYyCD/9u9p+
 O5uF1cmTop3D+HnVC45DYU9bwJgZC0Jo5pu434TS3utZrJ4U44WM8qn9fw94pKIwEnS0QX3ZGKL
 CKTpzBpDVnuQEwhti29re/GjcYBEM0Y6Rk+pJdZK9GBiJllM=
X-Received: by 2002:a05:7301:7305:b0:35c:dd03:55d2 with SMTP id
 5a478bee46e88-361a2a3ec54mr11621058eec.26.1792461116251; 
 Mon, 19 Oct 2026 18:51:56 -0700 (PDT)
X-Received: by 2002:a05:7301:7305:b0:35c:dd03:55d2 with SMTP id
 5a478bee46e88-361a2a3ec54mr11621032eec.26.1792461115684; 
 Mon, 19 Oct 2026 18:51:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360820a02b8sm38966065eec.17.2026.10.19.18.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 18:51:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Alessandro Di Federico <ale@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2] target/hexagon: fix allocframe FRAMEKEY scrambling
Date: Mon, 19 Oct 2026 18:51:54 -0700
Message-Id: <20261020015154.3600098-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=a7WlZkSF c=1 sm=1 tr=0 ts=6ad6c93d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=K1JGG7mlgpTgzTha6HsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 8seyVFHwnOKaOem3ZSxF2gB8RlzhLqTx
X-Proofpoint-GUID: 8seyVFHwnOKaOem3ZSxF2gB8RlzhLqTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfX7lsTt3gM1TZT
 dMQNbakruU0ESs7OG0L8DZp42ywL0DZ+Dt9vOy+lG5KfOtNbrg31a2+itoYAz0Jx4s67NxYFq2K
 Nx4tHvlNU34zco4j2wS79IDH4h7RJc4SegFnBCYSvTwKWPeyflPUDI6inDCtHQbPWZaR57VyeLP
 gd0h1/Mfk5rnAmv4l8ybGjoFrAWJyC+KWtuaU+m9AmWUQ454zZPgJi8CA83leYX/0Om7dvhcJcy
 tZZwTyITAYDKzUSxPEU/fcX9IpXvhWozmULKvahbIK8Z/cb7a3uMIMvcw2n/rJeOwI9yoOs4PYj
 nI5/2CfeVFefDC8tdefoZjYJw2bWpiDjrbvRmaF3fyj10iEcPxu3lmtyhzjYl1apsYEN2sKcTn0
 yWFX/OioE4CwYpXTN6d1B9LgSTmfc6tiSjmvaHkXr0Tf0n3kSxP0bcOOwNFJhNUNdOFdm2gW9Ey
 JRS/NL8GUKbw/mSHdIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfXyf7MyoHS/1K2
 n7rl7kX2r4VenjBDGCQwOL53v0M+reLXegtJKRNKQzqEruu6L5fvITA7BWgqjLKVwnG0rwwlthF
 SeWgLYWU8yLA//rx9AC/8fZW78u2oFo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200007
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
ZXN0aW5nIHNvbWUgYm9vdCBpbWFnZXMgdXNpbmcgUXVSVC4KClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9p
ZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jIHwgIDIgKy0KIHRlc3RzL3RjZy9oZXhhZ29uL2Zy
YW1la2V5LmMgICAgICAgICAgICAgICAgfCA1NCArKysrKysrKysrKysrKysrKysrKysKIHRlc3Rz
L3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAgMSArCiAzIGZpbGVzIGNo
YW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyBiL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFy
c2VyL3BhcnNlci1oZWxwZXJzLmMKaW5kZXggNDljYzExZmRkZDguLjE0ODQwZDk4NzM3IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMKQEAgLTE5ODksNyAr
MTk4OSw3IEBAIEhleFZhbHVlIGdlbl9ydmFsdWVfZnNjcihDb250ZXh0ICpjLCBZWUxUWVBFICps
b2NwLCBIZXhWYWx1ZSAqdmFsdWUpCiAgICAgKnZhbHVlID0gZ2VuX3J2YWx1ZV9leHRlbmQoYywg
bG9jcCwgdmFsdWUpOwogICAgIE9VVChjLCBsb2NwLCAiZ2VuX3JlYWRfcmVnKCIsICZmcmFtZV9r
ZXksICIsIEhFWF9SRUdfRlJBTUVLRVkpO1xuIik7CiAgICAgT1VUKGMsIGxvY3AsICJ0Y2dfZ2Vu
X2NvbmNhdF9pMzJfaTY0KCIsCi0gICAgICAgICZrZXksICIsICIsICZmcmFtZV9rZXksICIsICIs
ICZmcmFtZV9rZXksICIpO1xuIik7CisgICAgICAgICZrZXksICIsIHRjZ19jb25zdGFudF90bCgw
KSwgIiwgJmZyYW1lX2tleSwgIik7XG4iKTsKICAgICBPVVQoYywgbG9jcCwgInRjZ19nZW5feG9y
X2k2NCgiLCAmcmVzLCAiLCAiLCB2YWx1ZSwgIiwgIiwgJmtleSwgIik7XG4iKTsKICAgICByZXR1
cm4gcmVzOwogfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYyBiL3Rl
c3RzL3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAuLjE0YzdmY2JjNjU0Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvdGNnL2hleGFn
b24vZnJhbWVrZXkuYwpAQCAtMCwwICsxLDU0IEBACisvKgorICogIENvcHlyaWdodChjKSBRdWFs
Y29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJpZXMuCisgKgorICog
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1
ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkaW50Lmg+CisKK2ludCBlcnI7CisKKyNpbmNsdWRl
ICJoZXhfdGVzdC5oIgorCisvKgorICogYWxsb2NmcmFtZSBwdXNoZXMge0xSLCBGUH0sIHNjcmFt
YmxpbmcgTFIgd2l0aCBGUkFNRUtFWS4gIFJldHVybiB0aHJvdWdoCisgKiBkZWFsbG9jX3JldHVy
biBhbmQgcmVwb3J0IHRoZSBGUCB0aGF0IGl0IHJlc3RvcmVzLgorICovCitzdGF0aWMgaW5saW5l
IHVpbnQzMl90IGZyYW1lX3JvdW5kdHJpcCh1aW50MzJfdCBrZXksIHVpbnQzMl90IGZwKQorewor
ICAgIHVpbnQzMl90IGZwX2JhY2ssIHNhdmVkX2ZwLCBzYXZlZF9scjsKKworICAgIGFzbSB2b2xh
dGlsZSgiJVtzYXZlZF9mcF0gPSByMzBcblx0IgorICAgICAgICAgICAgICAgICAiJVtzYXZlZF9s
cl0gPSByMzFcblx0IgorICAgICAgICAgICAgICAgICAiZnJhbWVrZXkgPSAlW2tleV1cblx0Igor
ICAgICAgICAgICAgICAgICAicjMwID0gJVtmcF1cblx0IgorICAgICAgICAgICAgICAgICAicjMx
ID0gIyMxZlxuXHQiCisgICAgICAgICAgICAgICAgICJhbGxvY2ZyYW1lKCMwKVxuXHQiCisgICAg
ICAgICAgICAgICAgICJyMzEgPSAjMFxuXHQiCisgICAgICAgICAgICAgICAgICJkZWFsbG9jX3Jl
dHVyblxuXHQiCisgICAgICAgICAgICAgICAgICIxOlxuXHQiCisgICAgICAgICAgICAgICAgICIl
W2ZwX2JhY2tdID0gcjMwXG5cdCIKKyAgICAgICAgICAgICAgICAgImZyYW1la2V5ID0gJVt6ZXJv
XVxuXHQiCisgICAgICAgICAgICAgICAgICJyMzAgPSAlW3NhdmVkX2ZwXVxuXHQiCisgICAgICAg
ICAgICAgICAgICJyMzEgPSAlW3NhdmVkX2xyXVxuIgorICAgICAgICAgICAgICAgICA6IFtmcF9i
YWNrXSAiPSZyIihmcF9iYWNrKSwKKyAgICAgICAgICAgICAgICAgICBbc2F2ZWRfZnBdICI9JnIi
KHNhdmVkX2ZwKSwgW3NhdmVkX2xyXSAiPSZyIihzYXZlZF9scikKKyAgICAgICAgICAgICAgICAg
OiBba2V5XSAiciIoa2V5KSwgW2ZwXSAiciIoZnApLCBbemVyb10gInIiKDApCisgICAgICAgICAg
ICAgICAgIDogIm1lbW9yeSIsICJmcmFtZWtleSIpOworICAgIHJldHVybiBmcF9iYWNrOworfQor
CitzdGF0aWMgdm9pZCBjaGVja19mcmFtZSh1aW50MzJfdCBrZXksIHVpbnQzMl90IGZwKQorewor
ICAgIGNoZWNrMzIoZnJhbWVfcm91bmR0cmlwKGtleSwgZnApLCBmcCk7Cit9CisKK2ludCBtYWlu
KCkKK3sKKyAgICBjaGVja19mcmFtZSgwLCAweDEyMzRmZmYwKTsKKyAgICBjaGVja19mcmFtZSgw
eGYyMWYyMGEwLCAweDEyMzRmZmYwKTsKKworICAgIHB1dHMoZXJyID8gIkZBSUwiIDogIlBBU1Mi
KTsKKyAgICByZXR1cm4gZXJyOworfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vbWVz
b24uYnVpbGQgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBhNmFjZTRjNzdj
Mi4uMGZkNjJjZTdlNGMgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxk
CisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC02OCw2ICs2OCw3IEBAIHRl
c3RzICs9IHsKICAgJ292ZXJmbG93LmMnOiB7J2NmbGFncyc6IGNmbGFncywgJ2V4ZV9uYW1lJzog
J2hleC1vdmVyZmxvdyd9LAogICAncHJlZ19hbGlhcy5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAog
ICAnZHVhbF9zdG9yZXMuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwKKyAgJ2ZyYW1la2V5LmMnOiB7
J2NmbGFncyc6IGNmbGFnc30sCiAgICdtdWx0aV9yZXN1bHQuYyc6IHsnY2ZsYWdzJzogY2ZsYWdz
fSwKICAgJ21lbV9ub3NodWYuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwKICAgJ21lbV9ub3NodWZf
ZXhjZXB0aW9uLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCi0tIAoyLjM0LjEKCg==

