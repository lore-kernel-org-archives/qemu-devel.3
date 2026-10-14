Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B91CC6B33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8gH-00070o-Bl; Wed, 14 Oct 2026 19:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gG-00070Z-3v
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gE-0006Rk-Ou
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ENLwLs1013129
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9LqmaQlg+l8
 VaD4sUWv2elLsUOCGYayUxvY0jf79DRI=; b=IYR55xDyl5YZLYga0pXLheF/rYW
 qIQEKBBZ09LtmfdvipXz8OODnfQFH3BmL2n7txVEg36w+QOdK7Ja0B3HGvYgjQAp
 sHDtMAD0cxnFvuj+BV98qgCi75V87K6qvgInnV5WwxWbGa6ia+USt13NvWIlsfBc
 7OHUnu/y1N7MHEUNBeMPa+VnQFPvKZgNk8goJ93RA8sgrdHub3+a/vpdL1XFWRQi
 bcfsHMLGiNdJAMV7XcKhHU11gDeE53Jj+LK7Ue82m5rfL8GBLCvJeb6Vl5DXhbPX
 jJkuOyDkF82a7Voat+IyphEDmdgfSyoA7eAp1K7EKgrlYVer3s3m1ykhjJg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80ctuk8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6890282eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021591; x=1792626391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9LqmaQlg+l8VaD4sUWv2elLsUOCGYayUxvY0jf79DRI=;
 b=arHg9x5X3Rjm86hu7MsFNUot6Ra8hztRRy50HlY9bEiG3N/MHaeZ3gk6GD8lQalZRZ
 ApXpXz7ng5DBD0Mq+GzzjDQQRmngqdNVW2HVD26VqSQ/M0114DyIs2Zfjp/YeN1jEJ7C
 3VpiLhqI9BfpLdmEtad/wW3dtOaEcnC12wFhJGChc+pmonzv1ZZ1cv1h49Zb/APT4s8S
 ARmx4VhTGOwjFrnFJ4+9ZrjwcRgiP85QgAG93WWjKrPT0rWDze8YsHlBzjCrqvoCSOuO
 ZdSGRQzldJQLnXe4y5/49I/HM/guYSnA8/VK9brabkPOXT1lRfoBLya2sVBD59V6MaWg
 I4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021591; x=1792626391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9LqmaQlg+l8VaD4sUWv2elLsUOCGYayUxvY0jf79DRI=;
 b=e8fPEgEDoXVL4SCDekxDS96oBaDN4ePqtoi3teNC+viK447q0pUa60BrdfouzgVAJD
 ETnnEZDqQ1yCZs+7YP1pl8i0OfE/VKNgR4omTyxh5ttBdozoxR9U4x56H1EBumiD5+H7
 okq3azVJnncmLh4MlrP62LbvgeckixnmOqSWZ/Y6bDTPsYSbWC2E4039HPZ6quvad1Qu
 AilRb9Mn7pnFUI0lsXEl+pj09jZMHH17S1sfa4WubO+2Z+SfzaOuRa495y8vQDv8V9nH
 pqWic+rKrqLMYxjWvY8t903ZYp+8u4s778o5ZsJZ0L7oXFbiYGV5niBXZZhXr389Vxk6
 tj+Q==
X-Gm-Message-State: AFq9FYIq7PEb5BSxEz2UcBe1wuFCiiBX+vSoJSP1i84OMgpNlhyx7LPa
 kOLErB9v+VDGMM8Tss5UTAGFmowFx3aaWT7lTPid6LnOACGLzo763cs92KQW8zxz/1qfBTGzTZO
 3Js60Ag9zpm9ITEaJHQS+JlkwVQB0mzHljuMjhWF8kO+ZqMv2lVgEZ+SfZjM+wvsPeg==
X-Gm-Gg: AYBFou1hbS4+5QSW/gPYudESmdeEnLDxzoCFuJX4eZ2xMhJbN1U2tN3Nfxx5ivjEwq7
 oAe//+8eccOSU5cAobHWq+54mKTxI4Gx/eWTvdlxpuvexUEi00+Ew838rYbLC0foz8qqT/PzAEq
 uclQL39zavBjqrQAGeEN9864Yu2qNvKLWEecg9VSbUMpmoWdiI9xpmqCnO+aiR+SliMHbvDjdjl
 w7JJOlgBLEbawYFgNXE8ZcLRL5DDMrql02YR9+LuTHrwQyDbedEd9JIm2DlITlDdXS9CAWJirCm
 pCKDMTl6V76c8DRxWmo8fOvxnBHbQmFl1zf02a5fiOGdLtzxHXbRYrIUsGJGhnqM6qY503qI3Eu
 MK4/8MIcf5AwIwJOEfYVn000gqVNk05JS2/nUznF3cVAX+GpH+tNQiFyk3wDx
X-Received: by 2002:a05:7300:c8c7:b0:35f:4780:518e with SMTP id
 5a478bee46e88-35f478052f2mr258785eec.16.1792021590809; 
 Wed, 14 Oct 2026 16:46:30 -0700 (PDT)
X-Received: by 2002:a05:7300:c8c7:b0:35f:4780:518e with SMTP id
 5a478bee46e88-35f478052f2mr258760eec.16.1792021590266; 
 Wed, 14 Oct 2026 16:46:30 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 11/19] hw/core/cpu: add get_note_size to dump ops
Date: Wed, 14 Oct 2026 23:45:57 +0000
Message-ID: <20261014234605.209084-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX33cqqK0FE0aq
 AiKhyjj/TSORBc6qrC+QWDgMFpbN7rto63FqSF1WIj7rTwsOujMCZtTi680dbK/nhPxkeXuSJUZ
 sN6J/IQU/BT7DA024lcC4NXNkU/rBgI=
X-Proofpoint-GUID: 8lKCyVY0iAdxmM7ZxcAscNZBJXX2nkRK
X-Proofpoint-ORIG-GUID: 8lKCyVY0iAdxmM7ZxcAscNZBJXX2nkRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX0bcLXGe9MlCg
 yCCWKVR0C7IYsIE5ARfrmzmtfD7knFaHY76hh+4Vyug4G3N8qhociyP/H0c2J0AcWSZk4FuJnom
 sOfbISHWllLXOM8ESJigsZg9JFIMJQ8NbFhi2EzVgL5ymv6qAvUSFc2u+zV6eDGKmFi5I3vKIXV
 OnyZSz0muNJMIgeA7EqZ9STsBPja8PhH11H54r68kYSyWdkPyDLpydS+c2dh7O+lE0/cWVFomnZ
 65p6ut9TfAMoFByWjplfAErfFu0ixc9oXPvdV4K8rqJlaBtF23Yki1BQqvtvrOgMy8eQxPBkZIF
 TwH4TDP8biC7hqBtA4Gtuzp/BDQEaKkbET6uiByFNBOVbq0fF35ioUk9MgXVMeiZKO5N20CQu2y
 luh3CTDWcMWeGflzZUdSAUnxu5ByByjc5zKo+eNXEnm3jIpxCbtnX0eb3onyHUAqdNtIYyUJ3nI
 gALEfptRn7Jax7cUFmQ==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6ad01457 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=HQk6ys_xUCS4XjCNjwAA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140094
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

This allows a specific cpu to report the size of the ELF notes it needs
to dump its state, alongside get_dump_info.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/dump-cpu-ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/core/dump-cpu-ops.h b/include/hw/core/dump-cpu-ops.h
index 5e8a89cbbea..d9716a72529 100644
--- a/include/hw/core/dump-cpu-ops.h
+++ b/include/hw/core/dump-cpu-ops.h
@@ -19,6 +19,13 @@ typedef struct DumpCPUOps {
      */
     int (*get_dump_info)(const CPUState *cs, ArchDumpInfo *info,
                          const struct GuestPhysBlockList *guest_phys_blocks);
+    /**
+     * @get_note_size: returns the size of the ELF notes needed to dump
+     * @nr_cpus cpus, for the ELF @class and @machine reported by
+     * @get_dump_info, or -1 if this is not supported.
+     */
+    ssize_t (*get_note_size)(const CPUState *cs, int class, int machine,
+                             int nr_cpus);
 } DumpCPUOps;
 
 #endif /* DUMP_CPU_OPS_H */
-- 
2.43.0


