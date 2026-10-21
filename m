Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE2606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eUxLcP34;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J8AzBIPw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMoC-00045k-Sf; Tue, 20 Oct 2026 23:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMnp-0003Dp-H2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:15:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMnn-0002gw-Qg
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:15:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2FUX81957080
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YfBbz1ntshu7HTJMMRGMbG70uprZA/xRojya9HsrRiE=; b=eUxLcP346bJ9nyE0
 VDN9BEmJ7YEBDJMyzf0p+DeAbNsyExWygj3eHLz3dNkEQCzE+KGce51T7+fFDVK1
 MI9FKbNt9s1cc5wMueEV0+m8BWzwDmXoXXGFrUNdShf6ekumOxq4Z53QuvbgT2VG
 l8dW79OH90zxmFZThI8hIzqk5x7lJtywNBQaGriwh0lqCVwJi06R5HOlDd6k6m4Q
 Kl+pC07Q69qzUze7CrMVXeelArpxo6b4ggVBtHoecGb6lpUjXAnU5N9uOzAfsUFX
 U5RqagfPTlBA9gjDNIPQsc2oZKMGK0tpKpEEuw4uWzIP6vPm4EJU6j0ctxVNLizf
 ZS5wqQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hvb6nq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ce7a85f04so65047885a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552530; x=1793157330; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YfBbz1ntshu7HTJMMRGMbG70uprZA/xRojya9HsrRiE=;
 b=J8AzBIPwwVFCjbOTnwbxLJMel3vWm30fsS3vaBOjc5Kw0DvXFC/md9Pv4RAw7F2HCQ
 CE5/Y0oJI0ZU2V2/VSBPcXnbfNMCoGInwY2CsfcVNh10+FDYytHckb8NiSUxJUtP27dO
 zqoHZpRwvBMe5z6LuIiTQw6QVHR9enJF92tKG14TiM5NSx6kHzCoNY3RALWYFI3OEr9a
 Me8xQj/sR1AMa+pCY0BG41gW7j4gXvRU2BIu8HeKw15+LKtbgKKXdD6M57eWMi6l32CM
 8734dB3VQ5oPAA4UqJdHHxvO/alrA+pJlOTedYg/j971ltWtqmySz2zFf1aGC5141gTB
 Irhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552530; x=1793157330;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YfBbz1ntshu7HTJMMRGMbG70uprZA/xRojya9HsrRiE=;
 b=r7JByKjMPzYWvElEqbitn5rIMaqiD0ximuD7bXpSemrWGs0/oo1nUcB4ZjqU5z2a2b
 E4dpyHb7+s+NOO8cPa1PkuPGS28xQibox/2QwnxH53s785aIssdT6wTnMHVSSZhNI9rt
 HphFncrk9k+QvDBElj/OFibTxgTenEoOPeNHF//+qIqjGd9cRfZ/7T5F7A0Cqd1V1aOf
 Nfs8xjLZBP7tTVz0jzGpYUMX/P/Q7QZFEkI8cpWtyeU+j1aIhZGdwv9xQnN5IDgjNG5s
 yYo9kl/5v66/82kkni0kLmVQN22xRV8TmzI49IqQnPBZzYMlCxswDpG0uWj/91Vo/fgL
 euHA==
X-Gm-Message-State: AFq9FYLyofTpPQWzbWAoSEZF4O4tDLeVYjz27ILmxi2a06nYcBUEEf5H
 ay4DEIN5Hy5oaOhsDtvcVekhOYBFB4zVSm7rvMfzBg6NbOBVtdHFipAHhVVxpzUZa20VGVThND3
 UoTvdPEFoaifGuo6aq1qs30GPrQz8hXoLvZedABd3nyjR2EXjptPekp13dDX5iz6ZXAq6
X-Gm-Gg: AYBFou20MoU5VJx4BoMs5ixdIvt4PjmM76rYyaO0fsKllxN0vpCpzg65zodC71t99fS
 orkEoP827XuJWnQcRa9/dzEXaCYXoRKekE+HIk8EWiP24lYP4Ek8Dwk0egtqqDI7qpcFj6w7pjX
 Go1oemG6Kkhfm9FEjXSZ0ToSlaGHVnw+Q1TjVRr14ZaaOk+nMIv/iQR16LdGB/PSPByOH/Hg+ku
 nHA7EBulsqUZKIxYVaTTeovgSwsRRMZ9D0Y6hd0Kn/DaHtgxNKm/WgWDnhxmavSpQ+mgs4pPK0G
 36BEaXwnlfTW10xJtTk3iRaRciebhWBnchZVr7I8s51iikDD7U5nh01LdTTxuKviD8CUNeJmDeS
 l85dGlzypZUJg6MHA5YOAQE5Pv0h+Akbj4OoBFrjY
X-Received: by 2002:a05:620a:3703:b0:93f:1dbf:6cfc with SMTP id
 af79cd13be357-93f57fb8621mr221123485a.36.1792552529796; 
 Tue, 20 Oct 2026 20:15:29 -0700 (PDT)
X-Received: by 2002:a05:620a:3703:b0:93f:1dbf:6cfc with SMTP id
 af79cd13be357-93f57fb8621mr221121585a.36.1792552529285; 
 Tue, 20 Oct 2026 20:15:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25827087sm2413903f8f.21.2026.10.20.20.15.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:15:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 10/33] target/i386: Replace magic value by proper
 EXCP0E_PAGE definition
Date: Wed, 21 Oct 2026 05:13:43 +0200
Message-ID: <20261021031407.24862-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXzaVJsjcqDSpl
 mONt789KXPbdhQpLypTayb+kD3NX5YDFkz70JmoARRKzyGmANZL1Q44nM9fVuJglR9TheQ++BL+
 yicSkHLiY2n1+JbcGiI1pIWt7VRQiGluvTiVA4qnxX7H87fGnWdkVXwfLao8MuSeNY77WkndfES
 vVTMGLz6ezPo3WJuEbISF8pgAbLDtpl1ZIA7h2wfYXcq51kbHqtmKjK1nII9ddq4yei6LE/pO8V
 JuwjO+CKwSrDvNGKa+8YHR96DcuBn8Xw+NpBg4Fw8u24EMkILZ1eeMpkgKpappsMtIu45F0JLsS
 +jgCeVMQj18j0n03O+zxOS5r1fnZwxxxkRV9sXEE9GHBlwm728j3vP82enxTSVc9cxcWlqWbY3t
 vKcRvEZCtgpaE8MH/uvOZOlSykxtNzDHILkSxSvWB0D+7XscUPj3wA9cRDwCNoDkovePc4ms+el
 dcpucp6svf7QTtzFj8w==
X-Proofpoint-ORIG-GUID: iB20HoyktRpKEQPyzQdSD7mzl0MGJYB8
X-Proofpoint-GUID: iB20HoyktRpKEQPyzQdSD7mzl0MGJYB8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX0v5x1G6qNCYt
 6Me7DVdh2J03RyZfrD1IYm9zOsFxsg96RrGD8SJ4Dkndi+oYZojNclk4CVcTicoC8Vf//NJ3s1V
 PiNHwmQ1nn0WMbj8YY3hfLHY2weoKnY=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad82e52 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2cblKrENZZ9LBr9VnxsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

No functional change: EXCP0E_PAGE is the 0x0e page-fault vector.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index cad19f9ca6b..c89d97e022b 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1215,7 +1215,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
                      env->segs[R_CS].selector, env->eip,
                      (int)env->segs[R_CS].base + env->eip,
                      env->segs[R_SS].selector, env->regs[R_ESP]);
-            if (intno == 0x0e) {
+            if (intno == EXCP0E_PAGE) {
                 qemu_log(" CR2=" TARGET_FMT_lx, env->cr[2]);
             } else {
                 qemu_log(" env->regs[R_EAX]=" TARGET_FMT_lx, env->regs[R_EAX]);
-- 
2.55.0


