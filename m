Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E866606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QK4dpW2a;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tc3mp4b6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOx1T-0006uG-6N; Thu, 05 Nov 2026 07:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwyz-0004BK-0n
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:22 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwyv-0005sJ-6U
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:19 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tQ70406607
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d5K4JcG2SMSzYOlw+UxnOa1o9IBK/vKQnlK0cGaK9VM=; b=QK4dpW2almABbkWF
 FI/ZQBacy/zy4fZdeVh/YqoXXhW5gGEvdnW5evSczXWs54z5LXIWmz8S/C/aIh12
 LgVlV1jGBUamLFtP3bdrAWs06eN9lAEas4E1FDf3S0AJMBCFE4cEoEn7fWtsO5mo
 U/mxD6DcK7RV09LdkhKUT2/5awE3MlTc4LnOi9xuQnwLgljIGZIV7E9kt8XfYsHn
 Eba51Ndq4ArnJ8A42hPTJ2maFr0HJ0NTJeqP6xVvpZyYRiZYGO4PB/htDEqtCxFy
 pXHt+xjtyIkxl+Zax5K0MHAYljwPWNK7FphULXj5L3wxHG2HS2LlDP4DUj+E9NQ7
 TkHdtw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v1m89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:54:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso274759685a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883244; x=1794488044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d5K4JcG2SMSzYOlw+UxnOa1o9IBK/vKQnlK0cGaK9VM=;
 b=Tc3mp4b62qMq9PAOSA617s+LyzL7EIhF72mz1hVDZh/dPajM85ToWwY4GOeI2yjfRK
 MGLSUUlgJSsRQORgsAigcrPtGn36hHI0XsyeUnepLLPK7Da0X7gwCO2jTqfI4hWB8pcp
 orWDkEgpRdlIkw/ux8XQ1FBFqwGW+6zqjSmhH0+2rd2MWBVQcPN+OdZG9IYOXbd4006x
 fsR0H7r/3okAHgyHfd8VUf75fCqf0NXxj8bxwdGObR5aT63kE00DEvdjCWiC1g5BBYT/
 9d2wwKB0Ko5yODYKYYQdqdtHCOBYvxg36K5NtqIVoJifEyf6x5wbXsLx69wRp5TPO7aq
 +uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883244; x=1794488044;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d5K4JcG2SMSzYOlw+UxnOa1o9IBK/vKQnlK0cGaK9VM=;
 b=hIGOG4yoFapEZ8QcPWPvAOFt7uI4g3Qat0AVwyB5IPk9tXYMXAZ+MwdQkjA2ttBLtk
 m9mm/iMPYX5D4X1KOYvKO8Kc7+UnRgMJ0UdE/SnOo7SLeVfibvFUo4kc6GLdSYKQW4B4
 S9XavbBBgrNeYat2ZAKuChvnWuZmWN3yfvseM4hkqjVxs/dBS+Ou/Qe03M+LsD/T8fS3
 dZ4SuldfNh5GaLhndIwAGaZvf9MW/6GmsapEiP4mcrVCxFnLYC/yL8ZHsRLo/apM8Euh
 aP+HVrqSEkFypo3/o8eqoC3P7T5IGV2ZtJaFZtFmgcXW/EHEv3M8vCTmgZB0RvUDl4Iz
 CxoA==
X-Gm-Message-State: APuU4Z9J6hveEQIdORTtRqE4DKKp+TeFHb+5NE6T1xPZNhX97h2Ubzv5
 y4G4jTVS0pPtW/yTV7tKQg7RGQ0WubG1JL/27PVxWDZoP4VJLWXMY7ehvxRwf2erEdQz8+g/935
 iCBbbsiBYBNZv10x7XfmQPVuBX8+tO/98UiPE3OS3jau3pjXxm1BaZPmLB86RTMEHYg==
X-Gm-Gg: AYBFou3QmTzR02806NRqE0KduzUX09MLzXQuku12eeUCXYITu3CIdP3NOzrwr8ITss9
 kOQGXCkrjlWsVZSljehHuTghl6Tvlf/0UJRrIHCGl/qa4ttdVGE0Ij+2LcuYnB+Igb1cG94G1OM
 RK/SNrxVSUQ0aOmrZN/7m+HdVnTN/2ZPudS8TPgdmVPALmKBjMkrmOgq+yzEzte1hzEAEFs4wce
 JwOH4bEFsaDsA1drsETlXPF6XsiTwQegmXpuINAV0t385LlwP2kDxatzuDVuiSjGbSR9lBVDKz+
 dPxBKKKJXKJ3TGYDLSwmbC7s7nseeyi6Xjjp+vbFRC/if4O5qDPI7Y4gUnDgGaAwdyK67ZxJ+H5
 /4hVPuJVGYM4p1ZRjgXm3mIailmAUI3VF11tCkkoCA4cGHp6TAtArbIZGOAynfcRPgrbRwMy/7b
 IXkVf0Sl8AnM8GU+/zBOrMZtHl2JwMEw==
X-Received: by 2002:a05:620a:3715:b0:93e:6283:eba6 with SMTP id
 af79cd13be357-944216bd491mr3339198185a.38.1793883244483; 
 Thu, 05 Nov 2026 04:54:04 -0800 (PST)
X-Received: by 2002:a05:620a:3715:b0:93e:6283:eba6 with SMTP id
 af79cd13be357-944216bd491mr3339194685a.38.1793883243878; 
 Thu, 05 Nov 2026 04:54:03 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b57feb668bsm560273a12.13.2026.11.05.04.54.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:54:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 12/17] hw/scsi: Replace deprecated sprintf() with snprintf()
Date: Thu,  5 Nov 2026 13:51:57 +0100
Message-ID: <20261105125203.40320-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX8kGAZvwSb+nh
 PJ6IKRhts+MWcyvowofs35ASZSOWo9TFqtZS8k3wjc8mbz5Oay5a1st2Ub/vypXeMGdh52XDto8
 /r9EK2SlQTTNZPgIvD5W0ndSaSsMJRw=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aec7c6d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=yPltcxp4wr7_-ubAqhcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfXxyxAXfyrXW8F
 eN89dyR/IWtF2Gr/UgwXfaUpqSL0Vt/vlEXfiRqo7jrBFzea94S9frDkJ22NoTW8xO0RMXJn7mY
 xFS60d8MKzSF3vg4/1ox23ggRKztJozbwno97j3G6og5rKrfyzuwkOPKOKKPgPz5xq5mqUjE1yB
 uFemVlTQkykxeWKenV3/bKQuaXFFKbfGchi5nZ5Fh9JOBZgq4AJinz4qZrUUgU1uUuqb4lWyc1R
 3/jk3NnwP+UTio6wN59RXPHbr3mvqTEoIGol4bJ1lvAQC5zWx3XDfowxTgFZHyQN/eFKRAUexTB
 3jvApX8nTOi0ebrkJaW4aYYhdmKfvFrHkwZm7pVG97Ojw7b5HbW5AIIaBKJqHdV616h4rejatQy
 Zavl6sSYFBnMBMbhkVJirbLUe74psCjTgaVKg5zY9gc9Obm3JmedltP9koV5EM9eLx7Y1GsAfzG
 4u3479TZSibZOhIx65g==
X-Proofpoint-GUID: mU-1tS4F_WUr51a48hn_-_16gsvE_dI7
X-Proofpoint-ORIG-GUID: mU-1tS4F_WUr51a48hn_-_16gsvE_dI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to format command
trace, silencing -Wdeprecated-declarations produced by
Apple clang 17.0.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/scsi-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index e48fcb926f1d..61d9de30dfa0 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -863,7 +863,7 @@ static void scsi_generic_command_dump(uint8_t *cmd, int len)
     line_buffer = g_malloc(len * 5 + 1);
 
     for (i = 0, p = line_buffer; i < len; i++) {
-        p += sprintf(p, " 0x%02x", cmd[i]);
+        p += snprintf(p, (len - i) * 5 + 1, " 0x%02x", cmd[i]);
     }
     trace_scsi_generic_send_command(line_buffer);
 
-- 
2.55.0


