Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD0606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eOaJ5x6q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W9ZkagHN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIw1D-00026q-Pr; Mon, 19 Oct 2026 18:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw1A-00025e-Qb
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw19-0003vO-3i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:44 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZvfs2891557
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s6TNEU9KIO3dZhqOCGGkRCE5gGVeGbS3AbBOX0MoZyw=; b=eOaJ5x6qdvjlnn/C
 uFASeAGM7fDee1qw/x7Ht2EQo8XKgKhGOmjQdrTGVfwld7sPpagXjykT24AQ1yRI
 rE/RGCZnjM0PiITyLKvUbqrcQMN679VwOW+JsQGuN76sE0eAFnvcs+LBX2xOGHA9
 EAx9YRq+5/WRQqevHIe2ejcrcCK+jGWtjv63r3dyKMl6yXxJo6p/4mYuUveUc8gJ
 kwEqJ33a8CBkXgZOBBNkPSrDZ4su1lVUhfj6evMy4U5pPbpSeink72O764lpAAZe
 5KjkDkosg1eX2CmJOugoMaXJqmcUGHOPZnppCyJusTE8YEncRkXC7k+lIDNQmrVi
 7eEIwQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4a0wue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso7910344eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449581; x=1793054381; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s6TNEU9KIO3dZhqOCGGkRCE5gGVeGbS3AbBOX0MoZyw=;
 b=W9ZkagHNzlOMJkWOIzMeT/HjdKR9qTNm219nyFjodQAHZUmL2LP+neukuOtN/YR9j3
 JVXzX31gYxVVRHTo49i9IkFw77OTPBdLyQX+xOyztwKwnu7s3n0EXUCf8d495HiZuWRs
 iIMmzI92DkEGvU/JaKPf0QUmT7IEiJwhxlhDvt/Di0wCmrBrwrGE2AK7ElnoGZEuupF4
 Q9qNFAYDlQKTO4prHz0TJqz5T5YNjf9Z7VdelGyLR+rcYl7qM5vNonLpWO6AXvmPJt/v
 2RFVMqn6Nxps4mC+pGWvP7waCph9JVZFdX0pLcxyof3pcjaOj5j3L/U+2ptKp7OVl6og
 bpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449581; x=1793054381;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s6TNEU9KIO3dZhqOCGGkRCE5gGVeGbS3AbBOX0MoZyw=;
 b=SrAIWhWV37qtFpFy6gxXmhaMCbBMKlDlr7tMufeL1G/dtzulTFmRoVw0II0tLielO1
 5bKNYbqM5TA7hKLlVfI59T3oI1NFTl2yniU69C4gWpb7tlw9pU4sAQPT/0xXb4KYg8ns
 Iqya4mpd36rM8Bm0aEzXmC1tLPRhituoVQLZuFnTKVBAJzv2Bu4JYxflDtDaWw1T4XzS
 xw5lGwUgi733nJqaiTAigg4EsH9BaNhmw5OwEElDuRJeisetNSAr5YTs4SzVx7BYEAih
 k9MI+6Nxy8Jlk5ECASDkpe1ObQCxSDNrfumrs2R01X0pRxWUw/mk9l+m/eaTQ4+AJ3X+
 oDpA==
X-Gm-Message-State: AFq9FYJLLfLiZCPai4H+PsIrqW4A8nsyLkk6WNiBFxKQJdeEUNXqIvJY
 JUldeo3HinVKrngb+ujhJ13TwrXJnDX0ludX3AVWqgReVVdAqt6haHTXrez1IBctHvUusN8Of3A
 OhnzNKUIwXWNh1qzi6hjDhUTcxNVHblX6thD9oTn71FItYrgMQvcae8/EIWsn1izvBQ==
X-Gm-Gg: AYBFou2gfZtoh7PQ7U/14pRPOhrc7jX/4GMH5xsRLrn5lqeqxkxGeKAdfy2Fpz4LiFE
 pWR/YqK0vqFppCLrDj+P910OBQBBa5NnBhJ2uzF0GlNWja/tpk2TX8QtrZHuFYlaUpkt1m+3A7Q
 XkIjroIqHBUghU+5O8obt6Sy7u1Da/Xvw/dI1XKO4BUqFP4rK+X9MlDhC4zy9kwh9esUmmDxWGw
 UxA4+tf3WXmMFj2d+FqCa3mg+EN2jk/QuU5aEo7588M8GEQq/nnldKWX+wD4KPfGjN7v3UXFAwA
 G6tv6YBeJkR2pWE1JrFicnk1g6PV2K12hlJJiw3jzaIHQLl726cwy/QMNaX3XtO4K630MYLpTRH
 On6HlZTarrXPJ9i1pzkm1xMo/M2M1AEOlbkDnu1/Q9VSZgaY=
X-Received: by 2002:a05:693c:83dc:10b0:362:fa87:2aa6 with SMTP id
 5a478bee46e88-362fa872acemr9669069eec.0.1792449581029; 
 Mon, 19 Oct 2026 15:39:41 -0700 (PDT)
X-Received: by 2002:a05:693c:83dc:10b0:362:fa87:2aa6 with SMTP id
 5a478bee46e88-362fa872acemr9669048eec.0.1792449580473; 
 Mon, 19 Oct 2026 15:39:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm38908474eec.0.2026.10.19.15.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:39:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 4/5] hw/intc: ciad should forward its mask to l2vic
Date: Mon, 19 Oct 2026 15:39:32 -0700
Message-Id: <20261019223933.3248208-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
References: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX92okqELAvwF8
 /fv64x1cI4coJGMebwhOOGaahFfmBfbVvTSWgw0yWitIlSX8Tcf0YyGml6yrPZwThONAzI7T4vs
 9cZMpDrGqPmGU6uPgmXS6Igg8+aLOOQ=
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6ad69c2e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=zi4VUfZ7aQnuQJZsh1MA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: pLNF01pDfQQeY-ru-JA4cd1nNe6c08Yb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX0aXUgw8QfzJH
 MKsG3L8Kt/cfRidJ37bCY/x8pBQA2FrF9TKTdTmGqNoUaW/BWM1as425Mu0tDvhyImwaxRzgmaH
 zjg08wSLDF2J9L0BlGXeGLfgSIpp/cQ45Yt7Omt7DV7bZfarugtLXjRWG7TgTdvqQ/O+tVAvh6p
 Jfy5O8nEJ1A62QSJITCga7ucB/YUy4GHGKa8nGAnIyABS7mweDdBBXJnpN/04liVqHiajQxcvmj
 q2VCGXr9e4FNUojMnECOCV6lTWjtQJa1hOj+PeSz31nYU1drmlqqJ31+5gIfwAa/XsidpVXIFte
 LW22Y2hE294shTCgAanaFlpDM1Wlk73k8p1SMXNrXJ2PftyZuKqT+n4jqYXrYZeWDpA6+5pwlaS
 lRb5ZQhCQkAR6dYjLyt+Xi2wdGlhu1INJR9SCBX5/VHO27p3lBTtC/q46e+88X0OLUyjtN2A0Fa
 VsWTJit6v8XGo0o7DRg==
X-Proofpoint-GUID: pLNF01pDfQQeY-ru-JA4cd1nNe6c08Yb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190090
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

Y2lhZCBjbGVhcmVkIHRoZSBsYXN0IGludGVycnVwdCB0aGUgTDJWSUMgZGVsaXZlcmVkIHJlZ2Fy
ZGxlc3Mgb2YgaXRzCm1hc2suICBTbyBhIGNpYWQgZm9yIGFueSBvdGhlciBpbnRlcnJ1cHQgd291
bGQgZ2V0IGFwcGxpZWQgaW5jb3JyZWN0bHkuCgpPbmx5IGNsZWFyIHRoZSBhY3RpdmUgaW50ZXJy
dXB0IHdoZW4gdGhlIGNpYWQgYWNrbm93bGVkZ2VzIHRoZSBDUFUKaW50ZXJydXB0IHRoYXQgaXRz
IFZJRCBncm91cCBpcyBkZWxpdmVyZWQgb24sIGFuZCBvbmx5IGlmIHRoYXQgaW50ZXJydXB0Cndh
cyB0YWtlbiBvciBzZXQgd2l0aCBzaWFkLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaW50Yy9o
ZXgtbDJ2aWMuaCB8IDE0ICsrKysrKysrKystLS0tCiBody9pbnRjL2hleC1sMnZpYy5jICAgICAg
ICAgfCAxMCArKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgfCAxNCArKysr
KysrKystLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmggYi9pbmNsdWRl
L2h3L2ludGMvaGV4LWwydmljLmgKaW5kZXggZWRjMjc4MjY2Y2IuLmFlMDY3ZmU5NWViIDEwMDY0
NAotLS0gYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmgKKysrIGIvaW5jbHVkZS9ody9pbnRj
L2hleC1sMnZpYy5oCkBAIC0zMSw4ICszMSwxMyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzIHsKICAgICB2b2lkICgqdXBkYXRlX3ZpZCkoSGV4TDJWaWNJbnRlcmZhY2Ug
KmwydmljLCB1aW50MzJfdCBncm91cCwKICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHZhbHVlKTsKIAotICAgIC8qIENsZWFyIGludGVycnVwdCB1c2luZyBDSUFEIGluc3RydWN0aW9u
ICovCi0gICAgdm9pZCAoKmNsZWFyX2ludGVycnVwdCkoSGV4TDJWaWNJbnRlcmZhY2UgKmwydmlj
KTsKKyAgICAvKgorICAgICAqIENsZWFyIGludGVycnVwdHMgdXNpbmcgdGhlIENJQUQgaW5zdHJ1
Y3Rpb24uCisgICAgICogQG1hc2sgdGhlIENQVSBpbnRlcnJ1cHRzIHRoYXQgdGhlIENJQUQgYWNr
bm93bGVkZ2VkLiAgVGhlIGludGVycnVwdCBpcworICAgICAqIG9ubHkgY2xlYXJlZCBpZiBAbWFz
ayBoYXMgdGhlIENQVSBpbnRlcnJ1cHQgdGhhdCBpdHMgVklEIGdyb3VwIGlzCisgICAgICogZGVs
aXZlcmVkIG9uLgorICAgICAqLworICAgIHZvaWQgKCpjbGVhcl9pbnRlcnJ1cHQpKEhleEwyVmlj
SW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgbWFzayk7CiB9IEhleEwyVmljSW50ZXJmYWNlQ2xh
c3M7CiAKIERFQ0xBUkVfT0JKX0NIRUNLRVJTKEhleEwyVmljSW50ZXJmYWNlLCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzLApAQCAtNTIsMTAgKzU3LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMnZp
Y191cGRhdGVfdmlkKEhleEwyVmljSW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgZ3JvdXAsCiAg
ICAgay0+dXBkYXRlX3ZpZChsMnZpYywgZ3JvdXAsIHZhbHVlKTsKIH0KIAotc3RhdGljIGlubGlu
ZSB2b2lkIGwydmljX2NsZWFyX2ludGVycnVwdChIZXhMMlZpY0ludGVyZmFjZSAqbDJ2aWMpCitz
dGF0aWMgaW5saW5lIHZvaWQgbDJ2aWNfY2xlYXJfaW50ZXJydXB0KEhleEwyVmljSW50ZXJmYWNl
ICpsMnZpYywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgbWFzaykKIHsKICAgICBIZXhMMlZpY0ludGVyZmFjZUNsYXNzICprID0gSEVYX0wyVklDX0lO
VEVSRkFDRV9HRVRfQ0xBU1MobDJ2aWMpOwotICAgIGstPmNsZWFyX2ludGVycnVwdChsMnZpYyk7
CisgICAgay0+Y2xlYXJfaW50ZXJydXB0KGwydmljLCBtYXNrKTsKIH0KIAogI2VuZGlmIC8qIEhX
X0lOVENfSEVYX0wyVklDX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9o
dy9pbnRjL2hleC1sMnZpYy5jCmluZGV4IDczNmYxYmUzYjFkLi5iNzNlY2I4MjFlNCAxMDA2NDQK
LS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYworKysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC00
NDgsMTIgKzQ0OCwxNiBAQCBzdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfdXBkYXRlX3ZpZF9p
bXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKICAgICBsMnZpY191cGRhdGVfYWxsKHMpOwog
fQogCi1zdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfY2xlYXJfaW50ZXJydXB0X2ltcGwoSGV4
TDJWaWNJbnRlcmZhY2UgKmlmYWNlKQorc3RhdGljIHZvaWQgbDJ2aWNfaW50ZXJmYWNlX2NsZWFy
X2ludGVycnVwdF9pbXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBtYXNrKQogewogICAg
IEhleEwyVklDU3RhdGUgKnMgPSBIRVhfTDJWSUMoaWZhY2UpOworICAgIGNvbnN0IHVpbnQzMl90
IHNpemUgPSBMMlZJQ19JTlRFUlJVUFRfTUFYOworICAgIGNvbnN0IHVpbnQzMl90IGFjdGl2ZV9p
cnEgPSBmaW5kX2ZpcnN0X2JpdDMyKHMtPmludF9zdGF0dXMsIHNpemUpOwogCi0gICAgaWYgKHMt
PnZpZCA8IEwyVklDX0lOVEVSUlVQVF9NQVgpIHsKLSAgICAgICAgY2xlYXJfYml0MzIocy0+dmlk
LCBzLT5pbnRfc3RhdHVzKTsKKyAgICAvKiBWSUQgZ3JvdXAgbiBpcyBkZWxpdmVyZWQgb24gQ1BV
IGludGVycnVwdCBuICsgMiAqLworICAgIGlmIChhY3RpdmVfaXJxICE9IHNpemUgJiYgKG1hc2sg
JiBCSVQoZ2V0X3ZpZChzLCBhY3RpdmVfaXJxKSArIDIpKSkgeworICAgICAgICBjbGVhcl9iaXQz
MihhY3RpdmVfaXJxLCBzLT5pbnRfc3RhdHVzKTsKICAgICB9CiAgICAgbDJ2aWNfdXBkYXRlX2Fs
bChzKTsKIH0KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggOTg1MGRjMDcyODkuLjJiODQxNGY1ZjUzIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTYxMywyNiArMTYxMywzMCBAQCB2b2lkIEhFTFBFUihyYWlzZV9zdGFj
a19vdmVyZmxvdykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNsb3QsCiB2b2lkIEhF
TFBFUihjaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKICAgICB1
aW50MzJfdCBpYWQ7CisgICAgdWludDMyX3Qgd2FzX3NldDsKICAgICBIZXhhZ29uQ1BVICpjcHU7
CiAKICAgICBCUUxfTE9DS19HVUFSRCgpOwogICAgIGNwdSA9IGVudl9hcmNoY3B1KGVudik7CiAg
ICAgaWYgKGNwdS0+Y2ZnLmhleF9kZWYtPmhleF92ZXJzaW9uID49IEhFWF9WRVJfVjgxKSB7CiAg
ICAgICAgIGlhZCA9IGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhf
U1JFR19JQUQsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJl
YWRJZCkgJiB+bWFzazsKLSAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5nbG9i
YWxyZWdzLCBIRVhfU1JFR19JQUQsIGlhZCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICAgICAgd2FzX3NldCA9IGlhZCAmIG1hc2s7Cisg
ICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SUFELCBpYWQgJiB+bWFzaywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50
aHJlYWRJZCk7CiAgICAgfSBlbHNlIHsKICAgICAgICAgdWludDMyX3QgaXBlbmRhZCA9CiAgICAg
ICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCk7CiAKLSAgICAgICAgZlNFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCwKLSAgICAgICAg
ICAgICAgICAgICBmR0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFEKSAmIH5tYXNrKTsKKyAg
ICAgICAgaWFkID0gZkdFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCk7CisgICAgICAgIHdh
c19zZXQgPSBpYWQgJiBtYXNrOworICAgICAgICBmU0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURf
SUFELCBpYWQgJiB+bWFzayk7CiAgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+
Z2xvYmFscmVncywgSEVYX1NSRUdfSVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaXBlbmRhZCwgZW52LT50aHJlYWRJZCk7CiAgICAgfQotICAgIGwydmljX2NsZWFyX2lu
dGVycnVwdChjcHUtPmwydmljKTsKKyAgICAvKiBPbmx5IGFuIGludGVycnVwdCB0aGF0IHdhcyB0
YWtlbiwgb3Igc2V0IHdpdGggc2lhZCwgY2FuIGJlIGNsZWFyZWQgKi8KKyAgICBsMnZpY19jbGVh
cl9pbnRlcnJ1cHQoY3B1LT5sMnZpYywgd2FzX3NldCk7CiAgICAgaGV4X2ludGVycnVwdF91cGRh
dGUoZW52KTsKIH0KIAotLSAKMi4zNC4xCgo=

