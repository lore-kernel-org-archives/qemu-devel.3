Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569E606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mJtKRjpb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ftvgvbTu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQGuf-0003n3-6Z; Sun, 08 Nov 2026 23:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGud-0003mA-Fw
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:19 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQGub-0008SZ-JI
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:23:19 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93K2e32936759
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 04:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j+33Ii10m4b61yBznsrdxGBzoM/lb/burGz/zc9kk/4=; b=mJtKRjpb/wnnRnPl
 VfS40QTvdwdTbJsXBjivlD6Kd/uw5Q5Cb6adlqU2XziEn+0HPvRw9t58Z4hzK/NK
 vB3P+sZYOQMhNy33Pc7DeYcYqlG9PHI0n9crj1xPQmfKB20h4crcjUd4GS2mBxqx
 aMbCOzauCA/9clbvUyKBpNjManMBB30UZ9V4u/gSEhqF4V1rVMVDMoUoaEjA5dbn
 XcKzEfNGy7O+234Flj2AMCpL8ar5Ryh/PxXMmso1iM2KLW/XR3lEjzIcfZ5tALFe
 NN5iZsau55j93YA0wTxyS6Q7bOYJCPAcmGWx+E+oispia3TMMpDa7tK6r1EC9aMf
 xv7pvQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsuagvr2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 04:23:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36fe0b57d91so556954eec.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794198195; x=1794802995; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j+33Ii10m4b61yBznsrdxGBzoM/lb/burGz/zc9kk/4=;
 b=ftvgvbTujEUT4V6TxBEa+h8JenHRdjBjNq5BaQScIgx5m7QrWPkoCCXmBL/6zP2U27
 nYlZ9TtSKUzQOU8Jic4YJ4j6meYN5Od57XHngobDeVrXxAnrO11Z9tcGS32rIu/Lz1OB
 PufAFoJYbopa/nqQAX8so2jI6Vfao3FUyONbttu3AOs6nFSclSJJQ2uGDI65VpcFVKdd
 fIWs1juTOR2bEFgnFOXNNzYwXWCcPKb36NVhVPckEQga/bz+6A2PTNdrlvPcG2kCaiiY
 VLFnuB/nXln8DqKu10pAShsV7PllmVHndnx/kDM4OyXQoQ0x5qBgMfgvEUq0TcqHR54d
 m9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794198195; x=1794802995;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j+33Ii10m4b61yBznsrdxGBzoM/lb/burGz/zc9kk/4=;
 b=C462oO0xrxCniO1LPDq346OBCQoGZz3UTvObJnQGyX6AcSp/NwIiJmb7XzwpI2TuZP
 gj76/ZzSCaV+FKsuqJT3TJeSQwgNLBegWJ72C226k5G8y1cr96sJrFx7jxlLmzD1Y3ds
 SAsjCINwjiaQESw6XQAXukltabrks0SX3FT5qJ5yp1+kj9xTsCnuhdSR2LGtFfNS1+SE
 sb8uNf9HppJ7pItwpZPkAwpjYa0HjUgw2ZF403xzuey5AtVq47n8oNnpFst0HT5JcyMd
 PahOwKJUe44dEhYiz4aWyneiBRVojgJdMIfXwemPpHNL46vgyn1eMe00m1Lf4VUeJJg0
 bMDg==
X-Gm-Message-State: APuU4Z90KE4lVkV/rh3gbP194HTE527m+ssGKPs5LMgc2kd4Cp4WxyMI
 E8OXHt9srd3WhnD63NZbpv4fF/2oizZOOu4gqiCXk7Lu4xKCjyRqQVeDJ+yL/Nui+M4EfAlnnyO
 ReGUOeiBwNYz6xtVlAFCJE6yjQ1k8UEP7hJRZmDHtGFh7A4IWXfF83N+XgJo5kxI3/w==
X-Gm-Gg: AYBFou3prdJNp9M/r4rYiFMfVr8IpOZsA0IFvTp2EDhRp3Zhi6LsVSD95uzdxwbKSxi
 DOP+OqOFJHnG5jLDtL008EA8nZ0GR5/RMLkA0dZ+0gwQhW18oyt/q2KzGA3O1cs9DTRDXf6gOpA
 tJIOk7++nZRVEcfboLXWM+iI/Iw4y/wj5I8uTtw1UWUHnnhXgNWEmC3tJpbDXtGSxkkNh4znag+
 YlakZC+GCAuPcsO2Zsyqme10RBsayzJrrV7HtMSxvFof9iNzwuBcAW5VBybmJ/1stMTJ1rFS/tv
 KqAgEQ4w5TOVtDWAFIl32GSVoWoL8igJp/Nr0zLYSodfZfrkaOypuWOrDFLIoMCpISy84lRmpGX
 oqwMS5TPhcHIfmJBR5qCLWCvpC2urB30MJZv2SB3p1fZt/qDz+rDjR8RbRvGBITgtwJ11GvGDg+
 x0DRmeqmyuVPxZkM0dXeKt4g==
X-Received: by 2002:a05:7300:f794:b0:36d:d7ec:5e3d with SMTP id
 5a478bee46e88-37256de84a4mr5841361eec.21.1794198195342; 
 Sun, 08 Nov 2026 20:23:15 -0800 (PST)
X-Received: by 2002:a05:7300:f794:b0:36d:d7ec:5e3d with SMTP id
 5a478bee46e88-37256de84a4mr5841331eec.21.1794198194752; 
 Sun, 08 Nov 2026 20:23:14 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372669d2826sm10156773eec.29.2026.11.08.20.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 20:23:13 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 5/5] docs/system/hexagon: describe integrated firmware OS boot
 paths
Date: Sun,  8 Nov 2026 20:23:06 -0800
Message-Id: <20261109042307.1301438-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
References: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfX/ozzDEzZlscF
 I3ayK+3TNdsfuBLYiSxZwDGZBElmjNHHUzpCllbPEKx5JXnRkKBiruuRLJ24k4CAKkwgni828qo
 zkI/97moRVX/a+BpRfon+64sNoTpc4SK0jl0dR90jtsGpo75zQO128KcosV+8XJOulH/0GxgkzI
 CmyFonVH2yO/SewWZmsAFKrq0Ars/fcmXzzCratkIYIh2HxJqgASZs2Rn63hiRaL70ChHN72QWG
 OnnfjLJ2uyx9SGO2ui9gi/HrHmObQ3iXp2PzyZy3Ku7fylBMW9+OhOF15DZvvf13+OxKQFmQJPr
 tVJ/sDpOlIePMCpBWh+te3XI1mZMTSBlG57pSN595SIBPjPkhqRyMcPMJ/kluMa/XzSWTuD9hb6
 wcpiokapMIDqRLsILTzIr1E9ocwC5Lypm9/EnV9bEHSzbhmTtxTjZd2BAU5AhKYR/xGe6HWx1m8
 5aKzn9tRyRcVTaavKkQ==
X-Proofpoint-ORIG-GUID: Es8crcTpRaYFFmrXQMa43bn7HnKylwm1
X-Proofpoint-GUID: Es8crcTpRaYFFmrXQMa43bn7HnKylwm1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfXwDtyum+bmi6L
 iTdsA2OLB+ySh8AOafzfVZ0IapA7NgtRtAkaaDZmOtUvrGg4YOjIUPPJjrLJhCeDMz/6Mqhn/jw
 lnIZinUAqhCKl2puhugyylaTSv/r82Y=
X-Authority-Analysis: v=2.4 cv=V8LoQuni c=1 sm=1 tr=0 ts=6af14ab4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=CuL5fRHadp1A7yorxzYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090017
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

U2hvdyBob3cgdG8gYm9vdCBhIExpbnV4IGd1ZXN0IHdpdGggdGhlIGhleGFnb25fbG9hZGxpbnV4
IGZpcm13YXJlLCBhbmQKaGV4YWdvbl9ib290ZXIgZm9yIHJ1bm5pbmcgaDIgdXNlciBwcm9ncmFt
cy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiBkb2NzL3N5c3RlbS9oZXhhZ29uL29wZXJhdGluZy1zeXN0ZW1zLnJzdCB8IDUwICsr
KysrKysrKysrKysrKysrKysrKysrCiBkb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QgICAg
ICAgICAgICB8IDEyICsrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zeXN0ZW0vaGV4YWdvbi9vcGVyYXRpbmctc3lzdGVtcy5y
c3QKCmRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9oZXhhZ29uL29wZXJhdGluZy1zeXN0ZW1zLnJz
dCBiL2RvY3Mvc3lzdGVtL2hleGFnb24vb3BlcmF0aW5nLXN5c3RlbXMucnN0Cm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi5mMzY3ZmM2Mzg3ZgotLS0gL2Rldi9udWxsCisr
KyBiL2RvY3Mvc3lzdGVtL2hleGFnb24vb3BlcmF0aW5nLXN5c3RlbXMucnN0CkBAIC0wLDAgKzEs
NTAgQEAKKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisKK0Jv
b3RpbmcgZ3Vlc3Qgb3BlcmF0aW5nIHN5c3RlbXMKKz09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KKworSGV4YWdvbiBWTSBndWVzdHMgcmVxdWlyZSBhIEhleGFnb24gVk0gaG9zdC4gUUVN
VSBzaGlwcyBib2FyZC1zcGVjaWZpYworaG9zdCBmaXJtd2FyZSBpbiBgYHBjLWJpb3NgYC4gR3Vl
c3Qgb3BlcmF0aW5nIHN5c3RlbXMgYm9vdCB3aXRoIHRoZQorYGBoZXhhZ29uX2xvYWRsaW51eF8q
YGAgaW1hZ2VzOyB0aGUgYGBoZXhhZ29uX2Jvb3Rlcl8qYGAgaW1hZ2VzIHJ1biBIMgordXNlciBw
cm9ncmFtcyBpbnN0ZWFkIChzZWUgOmRvYzpgY2RzcGApLiBTZWxlY3QgYSBtYXRjaGluZyBtYWNo
aW5lLAorZmlybXdhcmUsIGFuZCBndWVzdCBtZW1vcnkgbGF5b3V0IGZyb20gOmRvYzpgY2RzcGAu
CisKK0xpbnV4CistLS0tLQorCitUaGUga2VybmVsIG11c3QgYmUgYnVpbHQgZm9yIHRoZSBIZXhh
Z29uIFZNIGludGVyZmFjZSBhbmQgaW5jbHVkZSB0aGUKK1BMMDExIGNvbnNvbGUgYW5kIHJlcXVp
cmVkIHZpcnRpby1tbWlvIGRldmljZSBkcml2ZXJzLgorCitGb3IgYSBwcmVsb2FkZWQga2VybmVs
IGFuZCBzZXBhcmF0ZSBpbml0cmFtZnM6CisKKy4uIGNvZGUtYmxvY2s6OiBzaAorCisgICAgcWVt
dS1zeXN0ZW0taGV4YWdvbiAtTSBxY3M2NDkwLWNkc3AgLWRpc3BsYXkgbm9uZSAtc2VyaWFsIHN0
ZGlvIFwKKyAgICAgICAgLWJpb3MgaGV4YWdvbl9sb2FkbGludXhfcWNzNjQ5MF9jZHNwIFwKKyAg
ICAgICAgLWtlcm5lbCAuL3ZtbGludXggLWluaXRyZCAuL2luaXRyYW1mcy5jcGlvLmd6IFwKKyAg
ICAgICAgLWFwcGVuZCAiY29uc29sZT10dHlBTUEwIHJkaW5pdD0vaW5pdCIKKworYGB0dHlBTUEw
YGAgc2VsZWN0cyB0aGUgUEwwMTEgY29uc29sZS4gYGAtYXBwZW5kYGAgc2V0cyB0aGUgYm9vdCBh
cmd1bWVudHMKK2luIFFFTVUncyBEVEI7IHRoZSBndWVzdCBhbmQgaXRzIFZNIGhvc3QgZGV0ZXJt
aW5lIGhvdyB0aG9zZSBhcmd1bWVudHMKK2FyZSBjb25zdW1lZC4gQWRkIGFueSBwbGF0Zm9ybS1z
cGVjaWZpYyBtZW1vcnkgb3IgZGVsYXktY2FsaWJyYXRpb24KK3BhcmFtZXRlcnMgcmVxdWlyZWQg
YnkgdGhlIGtlcm5lbCBpbWFnZS4KKworR3Vlc3Qgb3BlcmF0aW5nIHN5c3RlbXMgb24gdmlydAor
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorCitUaGUgYGB2aXJ0YGAgbWFjaGluZSBi
b290cyBhIGd1ZXN0IG9wZXJhdGluZyBzeXN0ZW0gdGhyb3VnaCB0aGUgc2FtZQorZmlybXdhcmUs
IHVzaW5nIGEgYGBoZXhhZ29uX2xvYWRsaW51eF8qYGAgaW1hZ2Ugd2hvc2Uga2VybmVsIGFkZHJl
c3MgaW4KKzpkb2M6YGNkc3BgIGlzIGBgMHhhMDAwMDAwMGBgOgorCisuLiBjb2RlLWJsb2NrOjog
c2gKKworICAgIHFlbXUtc3lzdGVtLWhleGFnb24gLU0gdmlydCAtZGlzcGxheSBub25lIC1zZXJp
YWwgc3RkaW8gXAorICAgICAgICAtYmlvcyBoZXhhZ29uX2xvYWRsaW51eF9zYTg3NzVwX2Nkc3Ag
XAorICAgICAgICAta2VybmVsIC4vZ3Vlc3QuZWxmIC1hcHBlbmQgImNvbnNvbGU9dHR5QU1BMCIK
KworVGhlIGd1ZXN0IEVMRidzIHBoeXNpY2FsIGxvYWQgYWRkcmVzc2VzIGFyZSByZWxhdGl2ZSB0
byB0aGUgc3RhcnQgb2YgdGhlCitrZXJuZWwgd2luZG93IGF0IGBgMHhhMDAwMDAwMGBgLCBzbyBh
IGd1ZXN0IGxpbmtlZCBhdCBwaHlzaWNhbCBhZGRyZXNzIHplcm8KK2lzIGxvYWRlZCB0aGVyZS4g
UUVNVSBlbnRlcnMgdGhlIGZpcm13YXJlIHdpdGggdGhlIERUQiBhZGRyZXNzIGluCitgYHIxOnIw
YGAgKHNlZSA6cmVmOmBoZXhhZ29uLXZtLWJvb3RgKS4gVGhlIGd1ZXN0IG11c3QgdXNlIHRoZSBI
ZXhhZ29uIFZNCitpbnRlcmZhY2UgZm9yIGludGVycnVwdHMgYW5kIHRpbWVycywgdGhlIFBMMDEx
IGF0IGBgMHgxMDAwMDAwMGBgLCBhbmQgdGhlCit2aXJ0aW8tbW1pbyB0cmFuc3BvcnRzIGxpc3Rl
ZCBpbiA6ZG9jOmBtYWNoaW5lc2AuCmRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS90YXJnZXQtaGV4
YWdvbi5yc3QgYi9kb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKaW5kZXggZGFjOGI5YjM0
ODMuLjNiNjNhOTRlYjU2IDEwMDY0NAotLS0gYS9kb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5y
c3QKKysrIGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CkBAIC0xMDUsMTEgKzEwNSwy
MyBAQCBndWVzdCBzb2Z0d2FyZSBjYW4gYWNjZXNzIHRoZSBob3N0IGNvbnNvbGUgYW5kIGZpbGVz
eXN0ZW0uIFJlYWQgdGhlCiBmb3IgZGV0YWlscy4gU2VtaWhvc3RpbmcgaXMgZW5hYmxlZCBieSBk
ZWZhdWx0IG9uIGhleGFnb24tc2ltLWNvbXBhdGlibGUKIG1hY2hpbmVzLiBUaGlzIGNhbiBiZSBm
dXJ0aGVyIGNvbmZpZ3VyZWQgdGhyb3VnaCBgYC1zZW1paG9zdGluZy1jb25maWdgYC4KIAorSGV4
YWdvbiBWTSBob3N0CistLS0tLS0tLS0tLS0tLS0KKworR3Vlc3Qgb3BlcmF0aW5nIHN5c3RlbXMg
Y2FuIHJ1biB1bmRlciBhIEhleGFnb24gVk0gaG9zdCwgd2hpY2ggcHJvdmlkZXMKK3ZpcnR1YWwg
cHJvY2Vzc29yLCBtZW1vcnkgbWFuYWdlbWVudCwgaW50ZXJydXB0LCBhbmQgdGltZXIgc2Vydmlj
ZXMuCitUaGUgYEhleGFnb24gVmlydHVhbCBNYWNoaW5lIFNwZWNpZmljYXRpb24KKzxodHRwczov
L2RvY3MucXVhbGNvbW0uY29tL2RvYy84MC1OQjQxOS0zLzgwLU5CNDE5LTNfUkVWX0FfSGV4YWdp
bl9WaXJ0dWFsX01hY2hpbmVfU3BlY2lmaWNhdGlvbi5wZGY+YF9fCitkZXNjcmliZXMgdGhlIGd1
ZXN0IGludGVyZmFjZS4gVGhlIE9TIGJvb3QgZXhhbXBsZXMgaW4KKzpkb2M6YGhleGFnb24vb3Bl
cmF0aW5nLXN5c3RlbXNgIHVzZSBIMiBhcyB0aGUgSGV4YWdvbiBWTSBob3N0OyBRRU1VCitlbXVs
YXRlcyB0aGUgdW5kZXJseWluZyBEU1AgaGFyZHdhcmUuCisKIC4uIHRvY3RyZWU6OgogICAgOmNh
cHRpb246IEhleGFnb24gZG9jdW1lbnRhdGlvbgogCiAgICBoZXhhZ29uL21hY2hpbmVzCiAgICBo
ZXhhZ29uL3Nkay1wcm9ncmFtcwogICAgaGV4YWdvbi9ib290CisgICBoZXhhZ29uL29wZXJhdGlu
Zy1zeXN0ZW1zCiAgICBoZXhhZ29uL2VtdWxhdGlvbgogICAgaGV4YWdvbi9jZHNwCi0tIAoyLjM0
LjEKCg==

