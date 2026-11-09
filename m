Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90160606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NoaB3JD7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LGT9ZAOy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUR6-0003xj-BL; Mon, 09 Nov 2026 13:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQUQv-0003w8-L9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:49:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQUQt-0005HH-0S
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:49:33 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH9h3846263
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 18:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tF/GJ4THGZaNjawB95yiOF
 n/GAO0t2untzlyC92TKx8=; b=NoaB3JD7q5pVGT1G+0j8TQX7cZWehoMEODH/+r
 ejpVaja3kRo0NdTSAqxF6GrM2yd9OMKJ0vxj7nAaITULW8pzrB4hL76+0YXpKVxg
 bseua6eF55wgyE46E27NFyGyKVZE7Dh2UCqnH/UCS/9JO7L1d50oXCDFoN14BPL+
 tyYtRWTf3qDJMB0QjgTtGSi84GPLKnAJu5q5qf6padLor4JVkxDkP7wlUDSWIASH
 VJbAvYJnX9E6D9B9zIgLMHOLnPbiOUwidtGvt9Br6QdXgOr9tkRNSJt2Jiid6yA9
 s2WsEAb1vlUmFTOw5/kiYKQ+1DPCZoAsdYz+TycQj6gwP1pA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucap9tfx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:49:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-370230d93efso531486eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 10:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794250167; x=1794854967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tF/GJ4THGZaNjawB95yiOFn/GAO0t2untzlyC92TKx8=;
 b=LGT9ZAOyp+Nix36gsq8NzEFPPOGPDTUpSXkQjXYbNGhXvhQbPJ9lxPOISX8aU+3E0P
 Tey1PSbweJ3aDz+nzzeysLHOoAVYpSLLgVIIpSC22Pw6JhXRAdwwNMk2B8KQrlb1u32B
 EfLYZuZ7i9t/o2EzPU91ry72DYQGYrxC0MiA+OLrjbt4fVgRgN2Qk5/x8qqmtKuRAJhH
 MTd/cx39zrlDpf8IMQR4FAKdA0G37PSfBWiAze2X6QC8aQbUx9oBZ8MIisPjg8J587wh
 5El7IUtBUbQxJjJLk19KZKEnWcz8U3uFpA3O7LW8K/k1mpWw5O9r5EXFIRmshOxAI7Fn
 KYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794250167; x=1794854967;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tF/GJ4THGZaNjawB95yiOFn/GAO0t2untzlyC92TKx8=;
 b=krPw+EGPv/y9vYYvWpbkt4qeKTGeNAmgelHmkZZMR/jIk9Jdi5B//4+agUP58HUG6s
 KbPWzGQvctseGlDfGdSJ9FI3uXvq6roY3RK738Eh56LXM3hMpI7EwaoK6yZmwUaXy3YB
 KddmdZrb79M2iapvp1Rd+SQkfwUnzWZpziGSy4MxlXkoGSTUzu8+BULdZ/BY25GyovG6
 P4YYgmgQPuC/zvi2aYOCa6nY0LlQOhbDsOS/NC6/ANqgDQ4kbXt/V5pIsMX3tLGOioNW
 XnPPU2q/j25g8JQeHid6MZfHIW0/lBke/6/g1lHMvPMJ3bd0NwOUUB52Wm3s3aPbgOtP
 zCnA==
X-Gm-Message-State: APuU4Z9Qn94DsHQeA7cIvscorsaXrOOjsQptgpdMuZVkrChUJHH1q7+O
 ZDHiTThSHoqPtTaYvMhvqNuTZec8Q15bMFB6wRWQHTYNrql7eDIIIjUgcMvacoL7ZB+9WoZeUee
 gwUQUiib9vGI0hNrvHHBgEKamFVnlx+s051YjTFhlla7D6JVSAtBnuEQoUOd4X2fJhQ==
X-Gm-Gg: AYBFou2Z50GJ55BLtZsuJaopGNXWHBU0ajlR5hrtwpSI3HBkib8QlKJwI0OZD6U/k8m
 38k6ewZtTE1YvDMreFwZPypcFOEvCuImSH+GJHBOS366UOWeUGSMtaILgDwY70hjjTquYgT0qNw
 e/MPWHnVH+N59Y14DTe7ZbyIPhf78uChK5oZg4MlO3CQHgHJCMHg6BJwrPzfqsgi1xUKIs9irJ4
 ftjLO/01ouP7rETWHPZeM0NzmfNvWyDuUs5m7zfjBQ68c4hdSs8Lny/JNmg6NOh4rDjSFnEx4pc
 QFD8ZmGTLI8fgCvLjuChorW8egwOpsCgTNG81HGZRZQjRJGXkwvBLA3qWtCu9Pb/ksSnJkt74iO
 t4JPLuanuTTRrsijl9op9K7B//vTQhi98G9qdQvtpcSlITnyqtkEu8eoUthtiZCfX57NVRzpjuX
 heGoD1nhk+4oD6vcLMOpka
X-Received: by 2002:a05:693c:864e:20b0:373:5ffa:b3a9 with SMTP id
 5a478bee46e88-3751fb36394mr182538eec.28.1794250167428; 
 Mon, 09 Nov 2026 10:49:27 -0800 (PST)
X-Received: by 2002:a05:693c:864e:20b0:373:5ffa:b3a9 with SMTP id
 5a478bee46e88-3751fb36394mr182498eec.28.1794250166876; 
 Mon, 09 Nov 2026 10:49:26 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe306e3sm239797eec.7.2026.11.09.10.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:49:25 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Hexagon: Fix virt boot
Date: Mon,  9 Nov 2026 10:49:21 -0800
Message-Id: <20261109184924.4149076-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfX6SfA8J0qh7+E
 qUoxI4CL6CCQvogFzW4Jd7d3Z3qqBq98cpPAcGjh45uKV0bBf234OszWy5BNc7ITUGIECAWznG3
 H4G3xJ3Zh/o/2KFgM87WHgFkFRb5szKM9tloUZFwX3uT/tq9E4g8LI/nICH/sDD1WaPmkJpmiB5
 9L6uylP0xbwlufoP4kVh3hRTl8/gbSB/zh0/ONM4ebpcvEZ6BhIcOHDCB7YJRZykq/54ZEmXrDe
 sn6oXQWWOA6Wrv3fDrIfrQEYlqkep+nTdUrhkQCsPIPPiTTuAe2EPIJxLx7X6AmVHH7bVkSDiWF
 CrWk3SCIS2nEAu/0GyjDdoYRhuuxOyO5522PsApMsgzxRdz8hnDtCrKpQtjUvWXUPMlNw0hdDkF
 iin/OFjEXgtPiWPdVNqvjGMaqamRURKqLaPWfVIdpzAPY5+aGDWNsDfgobNqKPd1BvbrMdSqKiR
 5FF+OuuB3sWfdHwMHWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfX5vGP6qBiKZda
 I7OGg4SRxF92lpfNpP9OEiMMMw4U3RYCpd6agQFQ2yFAtWZglvP3Cl72Une0fT8b1XFPCu0Z8ta
 ekToaCVRMwukb/bGOYMt5xWr0i81e2Q=
X-Proofpoint-ORIG-GUID: ZGSJxIZW069VGfW2BSyDjN9O1vn1Wozi
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af215b8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=23kEkXr_GDp0iaskoDcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: ZGSJxIZW069VGfW2BSyDjN9O1vn1Wozi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090074
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIHZpcnQgbWFjaGluZSAtYmlvcyBvcHRpb24gZGlkbid0IHdvcmsgZm9yIGgyIGxvYWRsaW51
eC4gIFJlZmFjdG9yIHZpcnQKdG8gdXNlIHRoZSBsb2dpYyBpbiBoZXgtYm9hcmQgd2hpY2ggd29y
a3MgZm9yIGxvYWRsaW51eCBib290cyBvbiB0aGUgbWFjaGluZXMKd2hpY2ggdXNlIGhleC1ib2Fy
ZC4KCkZ1bGx5IHJldmlld2VkIHNlcmllcywgdG8gYmUgaW5jbHVkZWQgaW4gdXBjb21pbmcgUFIu
CgpDaGFuZ2VzIGluIHYyOgotIHJlbW92ZSB0aGUgMHhhMDAwMDAwMCBzaGlmdCBmb3Iga2VybmVs
IGxvYWQKCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYxMTA5MDQy
MzA3LjEzMDE0MzgtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWluICgz
KToKICBody9oZXhhZ29uOiBzaGFyZSB0aGUgSGV4YWdvbiBWTSBndWVzdCBib290IGNvZGUKICBo
dy9oZXhhZ29uL3ZpcnQ6IGZpeCBmaXJtd2FyZSBib290CiAgaHcvaGV4YWdvbjogZml4IEZEVCBh
ZGRyZXNzIGFuZCBzaXplIGNlbGxzCgogaW5jbHVkZS9ody9oZXhhZ29uL2hleC1ib2FyZC5oIHwg
IDM2ICsrKysrKysKIGh3L2hleGFnb24vaGV4LWJvYXJkLmMgICAgICAgICB8IDE1MyArKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiBody9oZXhhZ29uL3Fjb21fZHNwLmMgICAgICAgICAgfCAx
NzggKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBody9oZXhhZ29uL3ZpcnQuYyAg
ICAgICAgICAgICAgfCAgNjggKysrKysrKysrKy0tLQogdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwt
dGVzdC5jIHwgICA1ICstCiA1IGZpbGVzIGNoYW5nZWQsIDI1MyBpbnNlcnRpb25zKCspLCAxODcg
ZGVsZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

