Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D78C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W49-0005yr-Fa; Tue, 15 Sep 2026 12:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3e-0005u1-9r
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3b-0003m1-Lx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:30:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFANUr813359
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /We6Oq3iZAEUwgNfTrkFRhUQjpmVek2fWNf2Goc+G1c=; b=fCKATV+JXzv6ey5E
 yfx4Yd3yJuzNtMeSgUdbhA4fYmlc3c7F4PVCdYZ6gkXWZJtYhksZr06wyYG+DK1g
 NUCuPC5qQj+aMFXcfxANIuZB3JciDWOdSATizgb1jyAHgrgx7ITvoh1M+qqqVV2a
 M6mZLmL4lWnrPt0WUuQst36OhIXXZs6Hp+np9AyEMRLPIuiRLziscz+6NohSU+qI
 RA0C8sDGizjJlyo6/dgT2Q0KZhjqD0/Qn8ezNrk0V7itgyOaAyKj7IBrY0e2s+ME
 zd2f/zOg4T8pE6ks0exnn3TSCn7nZdpLEw7TT8+V8pyQHxnxbyr/eU0KVzEgaeiq
 jRtNLQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq6kc170a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso6034127a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489853; x=1790094653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/We6Oq3iZAEUwgNfTrkFRhUQjpmVek2fWNf2Goc+G1c=;
 b=QMC415MhZ3Ob/DP1VOiCAUehjC+MGyFEd27zFkHPTrsR/IV5830T8OrZNmMbPfsuQ9
 j2UuhGFux9Gs4rG3pR8SWokvwjXkChfhdrc13TgZPUqlBO78gLB7NMxRBMbPfjPmbRO1
 2nUHrVSUXH4Hb8uTZXtWA/sj8C7RuP6RDMRxIoEHl4QHt8hcqaEI/SGWlBnFJMTn9Xmj
 zluRTiCwxvuaNJiDW9bRlTiMK1kYum00wcpYrwHp0xIDrPx9TlftFTFhmnqm4JTWRZoX
 ECAGpPAuy8M0upUZTUb0A7MwCyHmRljp572HWhIlD3JTx/vFbkwC/ixg+PX4Ecn5yogi
 tzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489853; x=1790094653;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/We6Oq3iZAEUwgNfTrkFRhUQjpmVek2fWNf2Goc+G1c=;
 b=PXbaRlkW/NSzx9gl2qBorUayVqfmA+I80tH5go1vdS9uhP3amGlQZ7WNAkHZ3VhWVc
 fOFnDOhrOppr8XxTv5tBREL9xMo11qRYezaYtP8Dr9K3tvvldyLgQo2aaJgBSmhl/Kv3
 LcgoACr1+HfR634SFj6mXkVTae+EO43jYYpoEDDiKrMeSyH187q01lYtGhk5S/hMCLeq
 gASV/Znc/wXmqF9cMtBGEbGxOEgtvF4AQ4ipgXnWjJRqN/AhRwD7xHUts/RyJnGRUec0
 9KIxz1pPFzItYkFL+evHiDQZt/WM/p+WnNNqmld7hCkM0N97HaLIwUYMTdqrmFACfB2C
 MRuw==
X-Gm-Message-State: AFuF++kqCzJfJc5OaVgj+cqA3FTLYlZ69bVVp/zR/3TuWV2PAT+qWui+
 pn8gKxCAIFeAUnFLElXmyeMgNqabZGYo8CfkmpAkTt0JRw/12ai52uI7sQPQPTTsHQqPQKCd6ei
 GHWfruoyNIhishabU2Eb2spEuKjYToBuFIkZXpXsIi4+PEP9x3D2mZuJ3vb9uJ0ceyw==
X-Gm-Gg: AYBFou1yFTHjg7cQpCkFLyJOHBcaZfn9B0hPDrrGAHuux6KkTS0kS7fK3v0Qol/htAv
 s7qs3dHf0grdhvlcpNis+5LoqNM+z76GkrwAw8eEaYToi+v5ATkEayKE8fhZCZwlFpckjmJSUXk
 scpBbAgvGF+5jzLvnsRCKBIai5O4FFGORD7w+2EYhwdWTOmOihTAnhWwDx3UR3JBDgULDOymjnF
 2rX77IQfaVsjhtQbL/G/XRcnfcxEut1vJt+AZqqYrocDbyTU24/luOU530VlIrWLkmNEgwGjqoK
 hw9bN+QCH1Ws0kbX0dBZvtBfi0rEKhthlLcqR8aOWTdRYase2x8qg+ii+njMP524deIaXdqqqke
 kFFWkxtBAPsCbq8LWDua8qWVfvPdOqTyj0/dcSeWj3P8E4dVA
X-Received: by 2002:a17:90b:258d:b0:39e:89d:21c9 with SMTP id
 98e67ed59e1d1-39e089d3e7bmr6053972a91.11.1789489851017; 
 Tue, 15 Sep 2026 09:30:51 -0700 (PDT)
X-Received: by 2002:a17:90b:258d:b0:39e:89d:21c9 with SMTP id
 98e67ed59e1d1-39e089d3e7bmr6053889a91.11.1789489850542; 
 Tue, 15 Sep 2026 09:30:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:30:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 01/17] tests/tcg/hexagon: fix undefined signed left shift
 in circ.c
Date: Tue, 15 Sep 2026 09:30:31 -0700
Message-Id: <20260915163047.4180600-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX+9CWZIkln/tx
 P85WwddSqaNV4eOmXkfcx0CAad/57b5aykl/s+bYtMWG/QXRQpp3yojyqOKjHQnapoqSe4bdIqi
 VPE8UP/gdVCC/xjFMkgfB49HJOCnG84=
X-Proofpoint-GUID: pXDVmVnWH7HKe5fP_9QRjHtXy2Js9gXs
X-Authority-Analysis: v=2.4 cv=ZINCCn7b c=1 sm=1 tr=0 ts=6aa972bd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=czf7IwGEd3W-wTYbEmAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: pXDVmVnWH7HKe5fP_9QRjHtXy2Js9gXs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX65wnb+lz08DU
 /4NcAQvs7gc0ySWVIMoNNNFzcPeY5K87G5ggiRxDStAfdsMQbcTOWS3cKIMkK+rYZoyduDzMUbA
 CIL0t7b8CZX3xAKmdw6iCuPPsvUdZEJ1bounkAVOOJS5vxGImFxQaFc8Xbu+3gL/IQxKhMqINKR
 2xEiEXonEQmqcvOlIJDLWVjNmt7CR6+uaxkg2RRK9WYTGwykA6bTP+7pwqjTiehZ7rD3euhwzJF
 uYJdHHlzZHQLPq+9XD1SxRanf44Tbqvxi+jT4P84ai6d3dDhRbnuhQqhthkV+KPBhDuugV0QVSj
 hgWwmuOEy05Pf/0DhyOf3qtluKUOwQVNUrYMzHcCfcGWA/WbWEyeOPo5vbzt2cWOCNaZT/09nxW
 Mj4vxHgmQHZGLUu9MW1bjEV/biASjT5/jRfzBvQ/rtABPbChR92d4XE5YNqMjIjkI8efAHzkmWT
 ON55hBs/EsNlmBhGlcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150239
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

Q2FzdCBvcGVyYW5kcyB0byB1aW50MzJfdCBiZWZvcmUgbGVmdC1zaGlmdGluZyBpbiBidWlsZF9t
cmVnKCkgdG8KYXZvaWQgdW5kZWZpbmVkIGJlaGF2aW9yIHdoZW4gdGhlIHNoaWZ0IHJlc3VsdCBv
dmVyZmxvd3MgaW50MzJfdC4KRm91bmQgd2l0aCBVQlNhbi4KClJldmlld2VkLWJ5OiBTaWQgTWFu
bmluZyA8c2lkLm1hbm5pbmdAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29u
L2NpcmMuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2NpcmMuYyBiL3Rlc3Rz
L3RjZy9oZXhhZ29uL2NpcmMuYwppbmRleCBhYjk0OWViZWYxYy4uMmExNWMzMjQyNDIgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL2NpcmMuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9j
aXJjLmMKQEAgLTk3LDkgKzk3LDkgQEAgSU5JVChkYnVmLCBORE9CTFMpCiAgKi8KIHN0YXRpYyBp
bnQzMl90IGJ1aWxkX21yZWcoaW50MzJfdCBpbmMsIGludDMyX3QgSywgaW50MzJfdCBsZW4pCiB7
Ci0gICAgcmV0dXJuICgoaW5jICYgMHg3ODApIDw8IDIxKSB8Ci0gICAgICAgICAgICgoSyAmIDB4
ZikgPDwgMjQpIHwKLSAgICAgICAgICAgKChpbmMgJiAweDdmKSA8PCAxNykgfAorICAgIHJldHVy
biAoKHVpbnQzMl90KShpbmMgJiAweDc4MCkgPDwgMjEpIHwKKyAgICAgICAgICAgKCh1aW50MzJf
dCkoSyAmIDB4ZikgPDwgMjQpIHwKKyAgICAgICAgICAgKCh1aW50MzJfdCkoaW5jICYgMHg3Zikg
PDwgMTcpIHwKICAgICAgICAgICAgKGxlbiAmIDB4MWZmZmYpOwogfQogCi0tIAoyLjM0LjEKCg==

