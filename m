Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24921606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=degPJnwN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A+woK06C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpx-0006it-OD; Tue, 20 Oct 2026 23:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJMoH-0004EM-Gl
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJMoF-0002oh-Ki
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F1QN336599
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d6YWos0L/Y4NwRTvC9g9TavF4CLiPqmOWZ7v5K5heGQ=; b=degPJnwNnSKUZMen
 UFyIfAQ4X/p2XhSQ9dhUKi4yWY917uhBS2eVbc5u4mO0tFQIk65pPNhBPDVSh2qI
 VEiwxeaAIym8LONz1+SVgp8nTTkMyJjTMo8e7TdLrTR9M4RF+qhEbGwpjijPtouI
 WLm+eIKGNoO+pUS9wSzSKI5SBXoG7ojU72nqjbWV57nf55myTJB3DoopqKTOk4do
 b8FKxAzDV/1PkhW+Q0T+g1gNzE9mVHq41g88rbmHtTWg0YEzoiF2Lxz1ZpECpxXI
 N/ztEja/Bf0K3mMQABfTqI5YUA4Ge63Llo9wiAN7K/j27nF+KuCP9THYDuGHW6de
 8PSA3Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabhrfd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso417412eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552559; x=1793157359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d6YWos0L/Y4NwRTvC9g9TavF4CLiPqmOWZ7v5K5heGQ=;
 b=A+woK06CO9WViEjZMRVKCSwUelRiGNSbFmWVr0EON9pkeEazxcf1UgMWw0c7jW24wk
 nDAgq615BaCU1uYJpz4+RmLZziNBdc2ph2k1F4qBu+LDegzCgeowe4I0N7MhiNtvNkzx
 qE0fm1+VdIlKrIJRN84ofroYHlTMLmKv6uJkaUhLkQKX7fy9FqZ+nsMCkAA7v39V0Irh
 7bJ20xODTiJJ9iqTN1DlRHuCI6r0WG4MTAF6mCgvayj/wAEShcVhm479IhzvohUbpv8P
 eAsTjhk4PsVvNaVvF55Y7owUoaYuJ1eknTWJeIoKiXYjFotd+YM8PVccSQX7fIhPlC/S
 SHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552559; x=1793157359;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d6YWos0L/Y4NwRTvC9g9TavF4CLiPqmOWZ7v5K5heGQ=;
 b=TrLl7x2+fS+n+Cj3A5jA2KTDQqdsVg6sQxkfH6U4Ie0QOUkmIkdxpUDoQ16QfDXBJQ
 3do0oS8J5YV0Hhf/s55/IiNsTN806xHJTwQz9f5ydtmUNsmb9M+fDNesiSc7JUdR8bNc
 wiCoAmfQpes3D9m3dOc0l96YJ0f8p3awTmSbfS5wWPLuKxx+IoDaG82omCpLkoYHMT55
 RakuTgDkKBIipj5M4GeJF8Eab7xM/aNLkk+cWwHP8/cLGI7mIEEDV+q4qR6hM7kDsas3
 CswveFUKcGDHON2HEslbjstxDrhnmdBtRv0IIVW/KQoyIKlT7n2XvmliYRllmX4vSPMB
 r6/g==
X-Gm-Message-State: AFq9FYLuw4nnaDxOtJ2eMvVBX/YS7aK3lgE9LUp5zPE2ca79m0v4n/cQ
 Gp8UZ12/jRPqV4+uVBZMD73bfQzSuw/p1Es7KT73sCAEDIupadTW4ti8bXbgAzA0qwq2/82SisP
 0gDUiNaYUh1opBgScdcNNotO9/q4dC7UsDaV0kRdStmXkPnVUijA6sf1MSA4MBIC3gA==
X-Gm-Gg: AYBFou1/vPN0KZ/rkhnr8+m8Dj8RcO9CcUzV2TDW7U6yF8bNaHB1PZh00b7BgcQXMDT
 tgqkjX8L1qbmH869BfOcPSAYeK+eb33fUlJ7siAz/5E7nX4oDtrUlGZLSrl4qVZ33WX99e/3LO7
 ChFWAuxRP9vWL1+fc9fYQ8JaZK5T/7h9B06sZToQt5ksmg+jKCYiFd6BbloMjFf6D2r3uBPsiF4
 Q8VtJTq/dqLiIeaosn+Zf/wf4g/PSGseG7j+CoBuUuXBHP1KuEgz/WReYwxlqLpYU+plgE3YRjT
 FJeLFuF0PPuEZ/jQO5zAmFYHhrDpaeWnRFPZFu3JELpccvaPonv4U3287pwl80T5UoJ+GvL98cU
 vQOHDaVF13l4aSrWbpmPX1ly0ASanhJbhiG78wsk1dgNBT+g=
X-Received: by 2002:a05:7301:f89:b0:35c:85fa:5a61 with SMTP id
 5a478bee46e88-3674f1186b6mr1361084eec.38.1792552559209; 
 Tue, 20 Oct 2026 20:15:59 -0700 (PDT)
X-Received: by 2002:a05:7301:f89:b0:35c:85fa:5a61 with SMTP id
 5a478bee46e88-3674f1186b6mr1361059eec.38.1792552558436; 
 Tue, 20 Oct 2026 20:15:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674198f1cdsm3208959eec.25.2026.10.20.20.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 20:15:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 2/3] target/hexagon: only flush the softtlb when SSR.ASID
 changes
Date: Tue, 20 Oct 2026 20:15:53 -0700
Message-Id: <20261021031554.1942011-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021031554.1942011-1-brian.cain@oss.qualcomm.com>
References: <20261021031554.1942011-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX8m9Pb6KuXkfR
 wPlDRXfWF4XzZsP9fUGJhlLVj3a22SjJ7gFa5kedrSu79gev6lRuzPzTFKO5JgugKIMyhADx/ql
 SMKgDVKsYY2uA3JS7Nc1u4SxLKO+aIM=
X-Proofpoint-ORIG-GUID: RGW-RrCdgi0MwhH60ShTVw6a7j8qFztC
X-Proofpoint-GUID: RGW-RrCdgi0MwhH60ShTVw6a7j8qFztC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX+fIg4JdDuUgn
 zr7P1Gp6LufG43WwgzQJ779q+cWHLEaHeYQ4oLhHlrvGxnj4bugX96yuxBOd7LqpZB68Zkfmxd8
 nVjv1UmkvOZ+TQIzeJVptZRz11QKLZPkoy8auqZKHgrqQAm3W1VM3J/x7F7yh611todUPmqoumD
 QfxJ68rrfvsByD7J3NcAkyjxkD7S2vuQJB8OHUUYQ9CBTTj9MnMY1etGVv209t5mPD+fer/Vmmw
 G56pdNazkeYyBtDc/Efh+ePauJ5QHmmi41wq4lBhDoIzmF1zQaIjbQ5GD4g31sCnpaoG0dNt1Zn
 XrddxgOm0sfkv4qvAWcr+i3OIIo+6oLrcrvin/N5wVXa+I9Yg4/kuRFSx7YSuP4CYFrlCzb3ne3
 s01OdpzoVRlsCoYBzqBeGrjY345bjhFg6pFSSuXT032naZI2uqGVk5LVCCqln2CkcnoUMmSkUxX
 3V/t0SNfVRdBcAzfzwA==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad82e70 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=03mWCbMf3N1Ipu_5KecA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210012
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

aGV4YWdvbl9tb2RpZnlfc3NyKCkgZmx1c2hlZCB0aGUgc29mdHRsYiBvbiBhbnkgY2hhbmdlIHRv
IFNTUi5FWCwgVU0sIEdNLApvciBBU0lELCBidXQgb25seSBBU0lEIGFmZmVjdHMgdHJhbnNsYXRp
b24uICBFWC9VTS9HTSBqdXN0IHBpY2sgdGhlIG1vZGUsCndoaWNoIGlzIGFscmVhZHkgY2FwdHVy
ZWQgaW4gbW11X2lkeC4KCkVYIHRvZ2dsZXMgb24gZXZlcnkgZXhjZXB0aW9uIGVudHJ5L3J0ZSwg
c28gdGhlIGZsdXNoIGNyZWF0ZWQgYSBmZWVkYmFjawpsb29wIHdoZXJlIGEgVExCIG1pc3Mgd2lw
ZWQgdGhlIHNvZnR0bGIgYW5kIGd1YXJhbnRlZWQgdGhlIG5leHQgYWNjZXNzZXMKbWlzc2VkIHRv
by4KClJlbmFtZSBoZXhfbW11X21vZGVfY2hhbmdlKCkgdG8gaGV4X21tdV9hc2lkX2NoYW5nZSgp
IHRvIG1hdGNoIHdoYXQgbm93CnRyaWdnZXJzIGl0LCBhbmQgbmFycm93IGl0IHRvIHRoaXMgdGhy
ZWFkJ3MgbW11IGluZGljZXM6IHRoZSBBU0lEIGxpdmVzIGluCnRoZSB0aHJlYWQncyBwcml2YXRl
IFNTUiwgc28gb3RoZXIgQ1BVcyBhcmUgdW5hZmZlY3RlZC4KClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9o
ZXhfbW11LmggICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgMTcgKysr
LS0tLS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyAgICB8ICA3ICsrKystLS0K
IDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmggYi90YXJnZXQvaGV4YWdvbi9oZXhfbW11
LmgKaW5kZXggMGM0OTQwNDQ0OGMuLjliNmVhNWI5NjdiIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9oZXhfbW11LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5oCkBAIC0xNyw3ICsx
Nyw3IEBAIGV4dGVybiB2b2lkIGhleF90bGJfaW52YWxpZGF0ZV9hc2lkKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBhc2lkKTsKIGV4dGVybiB1aW50MzJfdCBoZXhfdGxiX2xvb2t1cChD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3NyLCB1aW50MzJfdCBWQSk7CiBleHRlcm4g
dm9pZCBoZXhfbW11X29uKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIGV4dGVybiB2b2lkIGhleF9t
bXVfb2ZmKENQVUhleGFnb25TdGF0ZSAqZW52KTsKLWV4dGVybiB2b2lkIGhleF9tbXVfbW9kZV9j
aGFuZ2UoQ1BVSGV4YWdvblN0YXRlICplbnYpOworZXh0ZXJuIHZvaWQgaGV4X21tdV9hc2lkX2No
YW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudik7CiBleHRlcm4gYm9vbCBoZXhfdGxiX2ZpbmRfbWF0
Y2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFZBLAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUsIGh3YWRkciAqUEEsIGludCAq
cHJvdCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAqc2l6ZSwgaW50
MzJfdCAqZXhjcCwgaW50IG1tdV9pZHgpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IDZkYzA2NDAxYWQ1
Li42NGQ4YTJjYWQ3OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMjMxLDI3ICsyMzEsMTcgQEAgdW5z
aWduZWQgaGV4YWdvbl9odnhfc2VsZWN0X2NvbnRleHQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IHNzcikKIAogdm9pZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKQogewotICAgIGJvb2wgb2xkX0VYLCBvbGRf
VU0sIG9sZF9HTSwgb2xkX0lFOwotICAgIGJvb2wgbmV3X0VYLCBuZXdfVU0sIG5ld19HTSwgbmV3
X0lFOworICAgIGJvb2wgb2xkX0VYLCBvbGRfSUU7CisgICAgYm9vbCBuZXdfRVgsIG5ld19JRTsK
ICAgICB1aW50OF90IG9sZF9hc2lkLCBuZXdfYXNpZDsKIAogICAgIGdfYXNzZXJ0KGJxbF9sb2Nr
ZWQoKSk7CiAKICAgICBvbGRfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgb2xkKTsKLSAgICBv
bGRfVU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgb2xkKTsKLSAgICBvbGRfR00gPSBHRVRfU1NS
X0ZJRUxEKFNTUl9HTSwgb2xkKTsKICAgICBvbGRfSUUgPSBHRVRfU1NSX0ZJRUxEKFNTUl9JRSwg
b2xkKTsKICAgICBuZXdfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgbmV3KTsKLSAgICBuZXdf
VU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgbmV3KTsKLSAgICBuZXdfR00gPSBHRVRfU1NSX0ZJ
RUxEKFNTUl9HTSwgbmV3KTsKICAgICBuZXdfSUUgPSBHRVRfU1NSX0ZJRUxEKFNTUl9JRSwgbmV3
KTsKIAotICAgIGlmICgob2xkX0VYICE9IG5ld19FWCkgfHwKLSAgICAgICAgKG9sZF9VTSAhPSBu
ZXdfVU0pIHx8Ci0gICAgICAgIChvbGRfR00gIT0gbmV3X0dNKSkgewotICAgICAgICBoZXhfbW11
X21vZGVfY2hhbmdlKGVudik7Ci0gICAgfQotCiAgICAgYm9vbCB4YV9jaGFuZ2VkID0gR0VUX1NT
Ul9GSUVMRChTU1JfWEEsIG5ldykgIT0gR0VUX1NTUl9GSUVMRChTU1JfWEEsIG9sZCk7CiAgICAg
Ym9vbCB4ZV9jaGFuZ2VkID0gR0VUX1NTUl9GSUVMRChTU1JfWEUsIG5ldykgIT0gR0VUX1NTUl9G
SUVMRChTU1JfWEUsIG9sZCk7CiAKQEAgLTI2Nyw4ICsyNTcsNyBAQCB2b2lkIGhleGFnb25fbW9k
aWZ5X3NzcihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQp
CiAgICAgb2xkX2FzaWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9BU0lELCBvbGQpOwogICAgIG5ld19h
c2lkID0gR0VUX1NTUl9GSUVMRChTU1JfQVNJRCwgbmV3KTsKICAgICBpZiAobmV3X2FzaWQgIT0g
b2xkX2FzaWQpIHsKLSAgICAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwotICAgICAg
ICB0bGJfZmx1c2goY3MpOworICAgICAgICBoZXhfbW11X2FzaWRfY2hhbmdlKGVudik7CiAgICAg
fQogCiAgICAgLyogU2VlIGlmIHRoZSBpbnRlcnJ1cHRzIGhhdmUgYmVlbiBlbmFibGVkIG9yIHdl
IGhhdmUgZXhpdGVkIEVYIG1vZGUgKi8KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9t
bXUuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwppbmRleCAyZTBlNGFiNzA1Yi4uOWEwZTI5
YWUyMTIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYworKysgYi90YXJnZXQv
aGV4YWdvbi9oZXhfbW11LmMKQEAgLTczLDExICs3MywxMiBAQCB2b2lkIGhleF9tbXVfb2ZmKENQ
VUhleGFnb25TdGF0ZSAqZW52KQogICAgIHRsYl9mbHVzaChjcyk7CiB9CiAKLXZvaWQgaGV4X21t
dV9tb2RlX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3ZvaWQgaGV4X21tdV9hc2lkX2No
YW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBxZW11X2xvZ19tYXNrKENQVV9MT0df
TU1VLCAiSGV4YWdvbiBtb2RlIGNoYW5nZSFcbiIpOwogICAgIENQVVN0YXRlICpjcyA9IGVudl9j
cHUoZW52KTsKLSAgICB0bGJfZmx1c2goY3MpOworCisgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9H
X01NVSwgIkhleGFnb24gQVNJRCBjaGFuZ2UhXG4iKTsKKyAgICB0bGJfZmx1c2hfYnlfbW11aWR4
KGNzLCBNTVVfSURYX0FMTCk7CiB9CiAKIGJvb2wgaGV4X3RsYl9maW5kX21hdGNoKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCBWQSwKLS0gCjIuMzQuMQoK

