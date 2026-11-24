Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1AB606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=efxC0y/y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NMnOF3Te
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzf2-0001Y6-1a; Tue, 24 Nov 2026 18:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzer-00010X-KD
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:42 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzep-0005CO-R6
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:41 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMabEe3520034
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hpMPQEWSSbdr6E9zR9xbSL6ad/HVVk5bMZ8N6SuqCJ4=; b=efxC0y/y2HDBV2Rn
 QsojQ0kkx0Y8GGaKUV1ekeu5P3jf9JKril77fSzQnDLFQMz3PkgXSCEygvkjXIKB
 40zm+f9evO+PyUGYSYZcm35XHYQ+VldxPaWrawODBDqEg6VubObjmabnF1C+QpkI
 YTMgXF+Z+EX5EGHEhxFTIjJ9zWrJ6a3bPr+y3Idco1gXpOi8tjgLhKqCc/sVhB55
 7iCsyTKdcTrzb6dynbCBFKYvvc3QH2sDuNN9ZrFZfXAPzcZf4VxazWwxq4PphVD2
 NxyjxAKq/jfsyPLEeNxPMo12xhaN5g5SBvQhUpTSwtxq1gHzdVPeDUGzqQFxPj9L
 /fRzcA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5f00h7vy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94967c6d4f4so546955285a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561837; x=1796166637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hpMPQEWSSbdr6E9zR9xbSL6ad/HVVk5bMZ8N6SuqCJ4=;
 b=NMnOF3TeLvnci0yDEim0ZV5A25LYovP1J2eUh+pAIKRYVTqg5mZeR0f/KzOWlDdWlE
 /Wr3BxIe6Lx1P2lUyr6lghciEYshxIYX7jr6gDQ9iZS7FkDngXNfmspG3Q8bSIhb4hf3
 eLY5llzsJUiPJt8qt1IFWIYLyl0lfUge4Hkt/Io9BldS+pUHCV+PqQFOX1Ajwg+lhSLH
 mZ+NCiCyQa/Rk3IVyP+tlWX6/8fQ8imWBzHLnXdZkTcAQhQiKTxM16+TNhKPbWO1XRWQ
 0geYhN6ubfOI6g3QS8lRO+3Flk4YFoaAnEaxvllf29dKB7+6V1QRKNgbzcQ3IqPvz8Vh
 CvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561837; x=1796166637;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hpMPQEWSSbdr6E9zR9xbSL6ad/HVVk5bMZ8N6SuqCJ4=;
 b=iK7Vu15lJmuz3KepQvzUVGtfMm6TtjAUwzVvJ/KbFE+8mZyAiexX0snQ0JrtWGjK0f
 AyUm4fym/K8bxKJiyvE9vIR18HSOaqHehz3KVeL/h7SPv4fhTmi3RL8Yk1bNEOcJh+su
 sP9BB5yGPDZxk6ZmqpCiPXfoc9/pvxx6dbG9a0gvAD0U0eDQyf3SElMj2cfKhjQLpl1k
 PlyjvG1vTEbl1UCJ0U+0gNSotn8Uvq7h38+/h26OkO1A/wVbJan+0BtD7cMlTS+m1LXA
 IN0KalwaRNn/FREuxR4lWfNLgC5nAU2IWDUZyTD/VFf9gsXHa/pMhGTkbOqTUu+paVV3
 d8Vg==
X-Gm-Message-State: APuU4Z/jCxkNbJbEgQJt/f5wo81zR9MtW9EQiaWhmMzDTGXRv9pCzUu6
 Pn5iXnR5CyqlGbzL7n1iB2FOyqGBtLMtIhyQm3Zqi3mKvv47bobtRseWsdl3GbmiuC5APYT8aAz
 AAsvKCOiXa3F9oxYO/beq5tuZMX2XaeReAHjiHOQJmamHjPDxhxP0VOV1Pwit6TW3yFBf
X-Gm-Gg: AZFdTZdT/s7ddX4QG/8tNA70g1d8HFutHy6kzYSCvBw3uP+43JoasAtenlfbFJRuiqN
 YmqWEKyoy+PQp2Ub6pBZ51KYvbXz5vxNDAKsJzkQ1rVK+yl1XNjOlSzvECKoea6t+rf3w6kzhzx
 6rf2mthL8ERY6KAktK+Jeqp5ovEB2HqCCoeEWQNKCvVXRgdfDPdV/rilyNCGqHWSxAo9QnS/lhu
 PD7aSyKhKWl4P/BvPpRStYJGsJlq2FVrNpwCm30vE7eEzEE7odOjVbc66LgG8AjSQnGikTkfm3p
 qKH600QnmFK+sZO5NvtRXe9vciSg7s7ouM/C0u+W+7G87kJsBwnwo+BY1cxvMVwOSWgGaFnMusv
 RWDrhdX4g6O7p7BffOc127u+ylZR5E5pZZyawy1QRpSu+fpuKZ7uB9126kmIoChPhByyi8NQWAw
 vg203eii01YOsQUQ==
X-Received: by 2002:a05:620a:701a:b0:949:78dc:f90c with SMTP id
 af79cd13be357-949f6ee64c5mr562357685a.60.1795561837216; 
 Tue, 24 Nov 2026 15:10:37 -0800 (PST)
X-Received: by 2002:a05:620a:701a:b0:949:78dc:f90c with SMTP id
 af79cd13be357-949f6ee64c5mr562352985a.60.1795561836594; 
 Tue, 24 Nov 2026 15:10:36 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm34980599f8f.24.2026.11.24.15.10.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:10:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/17] hw/display/vmware-vga: Check incoming migration width
 and height
Date: Wed, 25 Nov 2026 00:09:11 +0100
Message-ID: <20261124230917.88704-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iWaWo3Pg-FF3ENZt8ZrJFjFhNIG2ewcL
X-Proofpoint-GUID: iWaWo3Pg-FF3ENZt8ZrJFjFhNIG2ewcL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX0XZFYDiMvQbK
 G4FWklroRwsmzu0FiHl6Sot51Cm//LfxqC0qRt59yI7baMHWjiMorQB43qMCsNwFlmun1lhR2Mg
 SAKk5ZfcAdEptE6PfVugvCtLFw0r/QQ=
X-Authority-Analysis: v=2.4 cv=JqtkP84C c=1 sm=1 tr=0 ts=6b06196e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=LSjrgreAm0ToU0vYokAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXzZzmOf8hsQbq
 BshrprJLu8ccl7eZCcxDtDrY/KFNPZvlyJI+oSfB+XRBpoRSDeBjsxrpOwDrbQQimoknLMUgSy7
 dvS8ES3YAQ9O1U4bF1c17yNsjvj9njrjOWy3GwB3ozMVDJ/i5RaYxM/7GLpKA+wqmDOsUV3GiuO
 5YhO7vkUWx2pUcqkbJM7Z0HYpIXj6Gx6VDQTvZWCsRtdYAfO2hiuvz0nOZnx6lrgCHnItfdljst
 EOovkrKwWhk7Mr/l0mfC9Hr3ZOa2T3NtSOx5YQV6KyViKM8vVDOY7b57a9KxyQrojAo4o9jMoQ1
 uKJQsbTj72hyJK/8n3Mp4hoE0naasPFRNEx6pAAX9n+uY99lAk+0ACNeNZa5R+76rEDDVo+ZHVR
 9oW5wGlwo33T9OI7jr4mOorlmeJWxFLJP2WnMP+927auFBXG4EumT2RN72FtrxVbKDxcDsz00Ow
 q5S+NIQyVV7F7cdkCdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The vmware-vga code sanitizes the screen width and height when the
guest tries to set them.  Apply similar checks on the incoming
migration data.  This prevents a manipulated migration stream from
being able to cause us to create a surface that exceeds the size of
vram.

Since we already put in a check against creating a surface that
is too large, the checks here are for:
 * ruling out a negative width and height
 * catching the issue and failing migration rather than letting
   it pass and then coping with the out-of-range values later

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3870
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124095719.4126146-5-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/vmware_vga.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index d4fff4619817..8db29eb7a8b8 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1211,6 +1211,11 @@ static int vmsvga_post_load(void *opaque, int version_id)
 {
     struct vmsvga_state_s *s = opaque;
 
+    if (s->new_width < 0 || s->new_width > SVGA_MAX_WIDTH ||
+        s->new_height < 0 || s->new_height > SVGA_MAX_HEIGHT) {
+        return -1;
+    }
+
     s->invalidated = 1;
     if (s->config) {
         s->fifo = (uint32_t *) s->fifo_ptr;
-- 
2.55.0


