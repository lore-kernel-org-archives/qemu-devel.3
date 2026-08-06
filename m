Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C036DC5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws5mL-000550-Mf; Thu, 06 Aug 2026 17:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1ws5ls-00051C-4W
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:37:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1ws5lo-00005L-4N
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:36:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676L8Ust091175
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 21:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5+o9K/PS28BHo5IT+4F/b2pAM8xtXnYIh/2rW4rVEss=; b=FfEkmrluGHGr/ytp
 Z5zk2PcI+8bPWiNhNs3WlPSRek/O57MgQunxMCgwXzcxUukZwBgNnSSJllqNa/0w
 TjWQE9slfHeUZGkzlRybiRVkqKr1mb5xZidHsgevSMCfmeRZo+MmsTj+AITWl8hy
 15Hg/sVDd2ZXHrX/XjXpqGzrezgw90u3Op7QJfNAPk+f04/9b+/GNyDPucozXZV4
 amqEX7hqmj/aT0NRULup5AB9JpUYqX3mOAYjuHk404D0SdkzUWbDS/XfzzANg27s
 skSQiO7srX48Ah6otrzwoi30aU8LXHp/kAiqeQvwWDxdDSSYuqr8jV0EQ2UrIWXr
 o0NT4g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6r8vme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 21:36:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so3859861a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786052204; x=1786657004; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5+o9K/PS28BHo5IT+4F/b2pAM8xtXnYIh/2rW4rVEss=;
 b=bWHq4lrelR+ncyCCOhaJvDiMjjrBcfC9XFcNMfsg/K44TNiRdMr7S15IxSlPvyYTo7
 OfRRA881WLnDA+GhRbGZbyaWARAmsFfC0mLuHD59M42sEnE2NTN73KefMKqJ3Kv3Vfml
 64Sis1GMPPBPxF//dcBWjcjJHoQ/PbmiyyN7Fx16JX1LUzlhnyuXUMBCV0tBqEU5Mdt5
 MaduOUte4uow3pg7b/s9riXXrRINzRCaNArnQ30Sa2xQIro2h+TJITxSjygJKB+Q7ddK
 1HjbHjoJtx92I+uba0DD/KVc3LZ1vEBt+4thip8nO5j3uHSZCU/AsPS5ljlep7xjb3uM
 ra5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786052204; x=1786657004;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5+o9K/PS28BHo5IT+4F/b2pAM8xtXnYIh/2rW4rVEss=;
 b=J516p27l/XS34f2CcmWK+GKOO1bCKFiPPwbx91Xs2fkn7u7qqfX6JEZ6nkXphB2d2w
 LP1vEh/pKvuBAgR4dWqzSYFbCVMjrWjpq0saM3gctgbs5CTTSUU4yGPK4t58g/TAPrfv
 PeYGkviXN6443GhVOc9bCSUR5NeBHd3i0wXgCPTrmByGghbptmKFwa6hM/Ub5E5DUAVq
 yz8vcbT8W9PKbP0YZAgdXMvbncWWyJUZtVL2NASzV+4oEUyFlSgBcqeH/zg71yey8jKA
 fi0IoeyamG0j7KKdRPLmL/pOOvvrrz7oyD1JU5OTGp61JwPzVV2QCMKP1xAgZBF0nuB7
 v8SQ==
X-Gm-Message-State: AOJu0YzZj1CBgTODCv0Uxrpz6gBuhmspT5LF48qwPAC3Wz/+sly1d6cZ
 ZMSJJxGbNUq96nhjvVxha1KLq/msvDE22UqmFZFddsqadywbnX+MOerBxN4ZkTfTGpLyMFzGWS5
 28OakpkOZ1+iK4fV4u1wDybCvo7KVsJ1KunQS5UUMnbvF7BLNIq4nBbMl8CXkrfrucw==
X-Gm-Gg: AR+sD11XbDZ+HHEe6I8MUx9MqFNOZxFs7rRO066rl3y183SWg30q0LJ8SY0xszOXkPS
 Naohzi9FjDuAxMaUGfVwUboDyiBcrP3dyfRgDk0PGbLDNKtWpRZ2o2fKMKUGD9/FBU/Etvx/Fis
 K2Xrtkjk6ttrKvrjKLgY3qXaAbG1VT6pZ/5+7AOtPHy2e3hMgij8EertuR+SXfoO8fv88VCx5N8
 WTnJ3YbWc0C+aVeZSIVGJl/omc4rp1hK6kKiGHhB5W3zBkZ7zBAwTLGUMbb0P4QXLiwsUUxmGhC
 1fTJK9MLbF0cLTFZDxcJ6NYb5P7KiNdlXoshS1E+ATA517COSWQ7uBZbSujv3WA/JYoZxMtniGY
 evvxgYy9ffXmPC4DC1OrrbTYIWhWyZV4JDB8uPALEdXf1o2jH
X-Received: by 2002:a05:6a21:998c:b0:3ba:cd5b:3dc8 with SMTP id
 adf61e73a8af0-3cb8603af30mr21058268637.31.1786052203825; 
 Thu, 06 Aug 2026 14:36:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:998c:b0:3ba:cd5b:3dc8 with SMTP id
 adf61e73a8af0-3cb8603af30mr21058223637.31.1786052203322; 
 Thu, 06 Aug 2026 14:36:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm223557c88.13.2026.08.06.14.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:36:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 1/3] target/hexagon: accept valid packets rejected by check
Date: Thu,  6 Aug 2026 14:36:38 -0700
Message-Id: <20260806213640.699905-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
References: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2OSBTYWx0ZWRfXzlMIH37m8i+5
 3VnNrQrIbffYbpM4qLsGcnPLRcL9nszfIS8wo007zFgy59Facuxng5VHEkVFAGgkq4aBhkvG/6X
 /JOvtGgccURBOT9w/L0QDyXbwy5/KTznxDxsPJMF0zFTF1zQ5ilkqZnQHJr9V+pR2KUVqLJCt8Y
 ITDUHkKu6F/gvJw/uG1BXColM+MIhNgXP2SuykKK7tsvM0SHga4m6hJClMl/Kg/Nt5XWL/S8z59
 +9lrVjE07qsumylkcDD/reR0QiVEIlSiQhYIu0/2Ci4msn7qB6JajMWNEFDr//8Tn88P5LeUMDB
 IR9x1FWsFBR2Zf2oAwXOuY7zjvj6fiIPzWF5jo4Tiq0jWARnaVbvRnjbgB08ya81oD2BAopwEjc
 JoWtKcxPF/bk/ZUzJklrMnXEICIXcMOuZXgkS6H8gv2ieZc6Ch2PJ4NGbtOhDs6YGuKdv4Of77G
 CBnXVgWcSovQ5inVtog==
X-Authority-Analysis: v=2.4 cv=HPXz0Itv c=1 sm=1 tr=0 ts=6a74fe70 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JZW4H54UH3-1LPv_A1UA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: UwyKjYDpGPRwxDwWo_nbivEx-YIKUedE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2OSBTYWx0ZWRfX1Ykup6h4I4F2
 onDw0GE/RkDcASqY077x8i9zhURP0xxuvbg7YEPFX0HebXTHzYLAMbcrC4ImFZmM9sHahoCD2bk
 g8PvphGSHQOO6fYFHdwyrXkA8Dph/y0=
X-Proofpoint-GUID: UwyKjYDpGPRwxDwWo_nbivEx-YIKUedE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_03,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060169
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

aGFzX3ZhbGlkX3Nsb3RfYXNzaWdubWVudCgpIHJlamVjdGVkIGFueSBwYWNrZXQgd2l0aCB0d28g
aW5zdHJ1Y3Rpb25zCmFzc2lnbmVkIHRvIHRoZSBzYW1lIHNsb3QuICBUaGF0IGlzIHRvbyBzdHJp
Y3QuICBXaGVuIGEgbWVtb3J5Cmluc3RydWN0aW9uIGlzIGVuY29kZWQgYmVmb3JlIGEgc2xvdC1m
bGV4aWJsZSBpbnN0cnVjdGlvbiBpbiBhIHBhY2tldCwKdGhlIGRlc2NlbmRpbmcgc2xvdCBhc3Np
Z25tZW50IHBsYWNlcyB0aGUgbWVtb3J5IG9wIGluIHNsb3QgMSBhbmQgdGhlCm90aGVyIGluIHNs
b3QgMCwgdGhlbiB0aGUgIm1lbSBpbnNucyB0byBzbG90IDAiIGZpeHVwIG1vdmVzIHRoZSBtZW1v
cnkKb3AgdG8gc2xvdCAwIGFzIHdlbGwsIGxlYXZpbmcgYm90aCBpbiBzbG90IDAuICBTdWNoIGEg
cGFja2V0IGlzIHZhbGlkCmFuZCBleGVjdXRlcyBjb3JyZWN0bHksIGJ1dCB0aGUgdW5pcXVlbmVz
cyB0ZXN0IGZsYWdnZWQgaXQgYXMKSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VULCByYWlzaW5nIFNJ
R0lMTCBpbiBsaW51eC11c2VyIGFuZCBhIHByZWNpc2UKZXhjZXB0aW9uIGluIHN5c3RlbSBtb2Rl
LgoKRm9yIGV4YW1wbGUgdGhpcyBwYWNrZXQsIHdpdGggdGhlIGxvYWQgZW5jb2RlZCBmaXJzdCwg
d2FzIHdyb25nbHkKcmVqZWN0ZWQ6CgogICAgeyByNiA9IG1lbXcocjMrIy00KQogICAgICByNyA9
ICMweDRhZTYgfQoKUmVwbGFjZSB0aGUgdW5pcXVlbmVzcyB0ZXN0IHdpdGggYSBzbG90LWV4aGF1
c3Rpb24gY2hlY2s6IHdhbGsgdGhlCmluc3RydWN0aW9ucyBpbiBlbmNvZGluZyBvcmRlciBoYW5k
aW5nIG91dCBzbG90cyBpbiBzdHJpY3RseSBkZWNyZWFzaW5nCm9yZGVyIGFuZCBmYWlsIG9ubHkg
aWYgYW4gaW5zdHJ1Y3Rpb24gaGFzIG5vIHZhbGlkIHNsb3QgYXQgb3IgYmVsb3cgdGhlCnJ1bm5p
bmcgc2xvdC4gIFRoaXMgYWNjZXB0cyBwYWNrZXRzIHRoYXQgbGVnYWxseSBzaGFyZSBhIHNsb3Qg
d2hpbGUKc3RpbGwgcmVqZWN0aW5nIGdlbnVpbmVseSB1bmFzc2lnbmFibGUgcGFja2V0cywgc3Vj
aCBhcyBhIG1lbW9yeQppbnN0cnVjdGlvbiBncm91cGVkIHdpdGggYSBkdXBsZXgsIG9yIGEgbG9h
ZCBmb2xsb3dlZCBieSBhbiBpbnN0cnVjdGlvbgp0aGF0IHJlcXVpcmVzIGEgaGlnaCBzbG90LgoK
UmV2aWV3ZWQtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRp
bm9Ab3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2Fp
bkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jIHwgMzAgKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUu
YyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmluZGV4IDZlZGRjY2EyNmVkLi5lNmJiNzczM2Jl
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vZGVjb2RlLmMKQEAgLTU0OSwyMSArNTQ5LDM1IEBAIHN0YXRpYyBib29sIGRlY29kZV9wYXJz
ZWJpdHNfaXNfbG9vcGVuZCh1aW50MzJfdCBlbmNvZGluZzMyKQogICAgIHJldHVybiBiaXRzID09
IDB4MjsKIH0KIAorLyoKKyAqIENoZWNrIHRoYXQgdGhlIHBhY2tldCdzIGluc3RydWN0aW9ucyBj
YW4gYmUgZ3JvdXBlZCBpbnRvIHNsb3RzOiB3YWxrIHRoZW0KKyAqIGluIGVuY29kaW5nIG9yZGVy
IGhhbmRpbmcgb3V0IHNsb3RzIGluIHN0cmljdGx5IGRlY3JlYXNpbmcgb3JkZXIsIGFuZCBmYWls
CisgKiBpZiBhbiBpbnN0cnVjdGlvbiBoYXMgbm8gdmFsaWQgc2xvdCBhdCBvciBiZWxvdyB0aGUg
cnVubmluZyBzbG90LiAgVHdvCisgKiBpbnN0cnVjdGlvbnMgbWF5IGxlZ2FsbHkgc2hhcmUgYSBz
bG90LCBzbyB0aGlzIGRvZXMgbm90IHJlcXVpcmUgdW5pcXVlCisgKiBzbG90cywgb25seSB0aGF0
IGV2ZXJ5IGluc3RydWN0aW9uIGZpdHMuCisgKi8KIHN0YXRpYyBib29sIGhhc192YWxpZF9zbG90
X2Fzc2lnbm1lbnQoUGFja2V0ICpwa3QpCiB7Ci0gICAgaW50IHVzZWRfc2xvdHMgPSAwOwotICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgewotICAgICAgICBpbnQg
c2xvdF9tYXNrOwotICAgICAgICBJbnNuICppbnNuID0gJnBrdC0+aW5zbltpXTsKLSAgICAgICAg
aWYgKGRlY29kZV9vcGNvZGVfZW5kc19sb29wKGluc24tPm9wY29kZSkpIHsKKyAgICBpbnQgaTsK
KyAgICBpbnQgc2xvdCA9IDM7CisKKyAgICBmb3IgKGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7
IGkrKykgeworICAgICAgICBTbG90TWFzayB2YWxpZF9zbG90czsKKyAgICAgICAgaWYgKGRlY29k
ZV9vcGNvZGVfZW5kc19sb29wKHBrdC0+aW5zbltpXS5vcGNvZGUpKSB7CiAgICAgICAgICAgICAv
KiBXZSBvdmVybG9hZCBzbG90IDAgZm9yIGVuZGxvb3AuICovCiAgICAgICAgICAgICBjb250aW51
ZTsKICAgICAgICAgfQotICAgICAgICBzbG90X21hc2sgPSAxIDw8IGluc24tPnNsb3Q7Ci0gICAg
ICAgIGlmICh1c2VkX3Nsb3RzICYgc2xvdF9tYXNrKSB7CisgICAgICAgIGlmIChzbG90IDwgMCkg
ewogICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgICAgICB9Ci0gICAgICAgIHVzZWRfc2xv
dHMgfD0gc2xvdF9tYXNrOworICAgICAgICB2YWxpZF9zbG90cyA9IGdldF92YWxpZF9zbG90cyhw
a3QsIGkpOworICAgICAgICB3aGlsZSAoISh2YWxpZF9zbG90cyAmICgxIDw8IHNsb3QpKSkgewor
ICAgICAgICAgICAgaWYgKHNsb3QgPD0gMCkgeworICAgICAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgICAgIHNsb3QtLTsKKyAgICAgICAgfQorICAgICAg
ICBzbG90LS07CiAgICAgfQogICAgIHJldHVybiB0cnVlOwogfQotLSAKMi4zNC4xCgo=

