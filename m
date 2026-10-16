Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE851CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmfC-0007eO-5O; Fri, 16 Oct 2026 14:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmey-0007dE-6P
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmew-0002xZ-BG
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5xCE1450921
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KNdJSxw6lnI
 w8GulV/ST8A6A+dKhkfuEhtyi8Ir9t1U=; b=n63WT+4BsliidocRbDyEHLB9uyk
 2l3NaG88i6834hJYFzSlcZAAK6v9w6A9ivfwYMVXc1U09ToEKeU5rj3NRfN1IK0z
 MFjaXd21zlTyKWRIY6uEDnqkNL4XVk7w8nbfwBhpBjH55FGnMQHHiAUE/yX/TGaq
 d0edZvTE7nibadwfewhwSVP3RpTB7PSAg2aw85EIkqGca0J11lRUNdeMCwVyjStg
 ieQk53otg0PDqWhDYxZg/ApYZaeNkb7DeiE/B1Wnzmjb9/W7xcyuV2Vy2FuZRFJZ
 Hz5pqIEQshQpWe7Su1Vfx1dTl+iqgSdKs9EMGtpIpu4MAT+YdNJ4VQ4Xhgg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur1uxm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:28:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-868db1b2c64so139604b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792175280; x=1792780080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KNdJSxw6lnIw8GulV/ST8A6A+dKhkfuEhtyi8Ir9t1U=;
 b=gJfJLSVoGlt1QtzA2NWOV+/ij0k2mAE2ajf0qL91gMRqSlfmF+NptvspV/61UyVG1K
 noVN9U1M/OEPXbbQj1HQjDP/Ttn0Ap2xoK1E5ouxC89PU989OPzeo/q8UCzN8oSrh0e6
 efVFioQwANDtLFMJ26O2KlOYDgyaANANs6hmeOxvTH/ZYte7qYIcorCsqq8rG2xvL+kS
 Tm9mVTFbiggBK1zAuXNJiJaTR8WpLJwigV+HZ7DDDmbqv7OEmt4uPDbXKTYtepm5nNWZ
 Cds1k28BsyinM/0Yey3rKqinRtchg1SffGFCxuRsOHQ3low4qtSK6pC/IGW1APdeaD6t
 ZjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175280; x=1792780080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KNdJSxw6lnIw8GulV/ST8A6A+dKhkfuEhtyi8Ir9t1U=;
 b=WjT11dv3N7/Hgy4M23aKbEjjZMUTu5oGpFYmELtsUN1gRQFjMhPwnsKAUJ/uD6Vu9O
 pSiluF3ffrfJv6R+wiYH0OsC1rB2airjh04dM9sLF2XQdEuYoWLz1b0X0Y+WPt2kq7ce
 vGDQfzMINFuAjcEIOR/OQZTfpE/1O5c3Y3t99GCLTVo11vGyPTa1kJ8O4X+NsK79rTPd
 XEaxrKIdWW37Qye9HjINpQQl8SrB+vyL+LCC0UZYjjxmYNkeoB5S+G4SrfzIRT8mQDOJ
 QYqTw0w57yeFG9VirZhn0VLEi4CzqJvatm9xPLqjg3P4aB/k+gt55AOR1s0lliQi2cYV
 JThQ==
X-Gm-Message-State: AFq9FYLRajCYYdnjwQX564OXDeFRXDVRyax/z76ckXjCMsEzM/64tnkM
 GVnojJYb0xJgyJ7Gtvj6DaLI7BFCBfrvS63BcYcz2sCHZnEmcZeZ2uY4ZT7E1sIMOSfKfPLtsEi
 cbZitpn1iMBLX9AXIAnBHboSQoAsB/dHxxxD5YniqAwgHTNNBd/HG5ARvOmUABPEXdQ==
X-Gm-Gg: AYBFou04nDDN1i3L+7EZKFAg9/stj6DpmUGuZlRJKJn2PWDqGedPmDmv0AJAsy1xHbS
 3IYbF1h0acsdM2j4pHU53Z922eHPSIMWsWxCNjq1UfNAKJCF/RJ502jn8F7TaKvolnE2BRQHtmo
 tPMD0qtBj71EQQXTRrWsHwiiI1kHN02hPSzAsxqxAvEAlNpA2pWHmLvBoUKBmqzgCc/fr3T0ekk
 5YaLpg1H+P00byQoyDTdDh9CL7Gq5NmfS2QKqLkl7AjBzaRQjsHRoxPrnb5qy0csIrrROY4NQu2
 YnfEARD5Pu2QRZWeTBfXUSML5aam1/ytGwYlu5LMaaVFia4aIE4MMUoMB3+xaIGqKiMRwKYEETg
 wbG0oblota9IAX4TCptN1iFYJb7C6RUoRppxHhuy6HDYqY5s6zybMvoTWmf8JEO4=
X-Received: by 2002:a05:6a21:6b02:b0:3dd:a197:cf2a with SMTP id
 adf61e73a8af0-3e2260b9902mr119061637.78.1792175280509; 
 Fri, 16 Oct 2026 11:28:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b02:b0:3dd:a197:cf2a with SMTP id
 adf61e73a8af0-3e2260b9902mr119043637.78.1792175280055; 
 Fri, 16 Oct 2026 11:28:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549c7034sm1557291a12.16.2026.10.16.11.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:27:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 6/6] meson.build: add riscv64-softmmu to multi-target
Date: Fri, 16 Oct 2026 11:27:51 -0700
Message-ID: <20261016182751.264704-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfXzWPhgbzXbZ0B
 7/W8d491l896YPdNvM0j8Wmn4GT2owJ1nJUb2+o8mFx0S9MGoNTpW/nHJNxOUNUrvJRZfZ64X8/
 y/vIqHWWVArbmEEoM4ylE46eyCdML08h657x7czc+unLSROeOY9yc+tK/Ww1b7N5aeFSUnvwQmS
 by2lrlmGXA3qjSsBpYPyw+UqPTjReKpigQET0ns3A6/LlbKcJ3/+PprrblAJc/t5FyTjPCSwdFe
 nwhbwXBgrRi6906xy6YtSqKkncYavyP419IBS2eL8UGruIFn7lIhTUOCnw2Y1D0EDM1lURylt8v
 CkbYQjoGZ4D2R8YNiZyUAehtVdXzpyerme2C8etTnBkHXP/8vZIP/jSxtCHBCG1QSDDS1W4r5hy
 qJ+NXsxWLqYf6wmQ+BCcRePpV2QMF2vffg1vloZivcTjB6N7gVm2pe3XVFafUV7WYFt4l7mPqIv
 OAiBlrWcUZlt8D0aZNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfXzCUjqO49/4l/
 3C9+NcMouYfUy7KEagfNwEhA3RWPMXG2Ibed4qdNkA8E+LnIVGI9W6BJShjCKonM2WByrn/LIbV
 0jFIDb6kq2UfK64+rOMgrmYFQOT4coY=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad26cb1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=IumKKtPryP_tiu38O98A:9 a=0onN0qhrqtgA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: QURKwm0lfmCIUNMOsaUsvIs16qmtJ0t0
X-Proofpoint-GUID: QURKwm0lfmCIUNMOsaUsvIs16qmtJ0t0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index b67a97ab458..c76d1bba5b2 100644
--- a/meson.build
+++ b/meson.build
@@ -4280,6 +4280,7 @@ multi_target_supported_targets = [
   'microblaze-softmmu',
   'or1k-softmmu',
   'rx-softmmu',
+  'riscv64-softmmu',
   'tricore-softmmu',
 ]
 
-- 
2.47.3


