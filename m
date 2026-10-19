Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D664606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M8olma7i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZJyQXJq1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuvQ-0005A8-Ax; Mon, 19 Oct 2026 17:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutZ-0002uv-Ip
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutU-0006KP-N5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK1Ka3103602
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4CsYxif/8PEBXd1gkWCK2+Mp3hAOIzN3ddjR2aZALQ=; b=M8olma7iMQVnNTAh
 SUjV3OwjNMk1nW+leAW5iw7XvF2woO1uAUIbSnOnjwueSW//tcjVz+Xr9ytR/Eac
 AxdOMaMF98n5XNMBNTbO27nGq+j5173ZnGFuVcOslkDeaijR7z8nq6mXMj8PbQEg
 scM/dqU3YWIy3qhHGfPOi9nk71UcJ9jhHUYubODGOTmfqDt4MCi7R+7Bxq+D5V+B
 O2Tx2RVOp1HY3lVuYbmThaHPlrooNuSghgcqq+sOikfkxFeCYLLUiOwo4t9wbvSk
 UpBff1dqRQ7sJkhrGP0eQrXfR5p9L0HJ8GFE+8qJwwfKb7H27/ntHAVeqUX35smY
 TWfWEA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0pcg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so83957a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445240; x=1793050040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T4CsYxif/8PEBXd1gkWCK2+Mp3hAOIzN3ddjR2aZALQ=;
 b=ZJyQXJq1pqk7WXGGIdS9wxAw2QIRLoTAzWee2d0vGZ1Xz6pd56LdBfXHx6qOdpN3LN
 EKc2ZkIEqImDY/diY5JEZw+/v1OIXA3TugOepiL4oEMbpj7KYTvhu9NZWvXaMDP8+csV
 aEQXxzKK/u9mjyDJ6xtUSs0mRHLKobMoo06nH/qL605S71F5wJqLHlSEMx//uEq+KhXQ
 Y5PlcCM0MMVJmbhWIYo63tqqG8Of9vY+EYIXYmLR8ovlDYNfleuUb6mlPbQ/yBs3Zayv
 ouC+NGB+m/41uxGWpe/owVka9nsfJ35Xz5PWjadiPHRc/f9NQ0R42E857DuoQwHGDNYn
 3FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445240; x=1793050040;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T4CsYxif/8PEBXd1gkWCK2+Mp3hAOIzN3ddjR2aZALQ=;
 b=R+lFMO3LHQeowu8f/vUxCq6YZBsLNoLhd1AvfQr/Rt17RkX0MG/vPVR3Ppbgfenrl0
 LWncWRRRWv0NRAc93iw1vGJMLoUAxOVFAEA8Ec/jPVQeydi3dTG5tOg1ZeX+lmBJaYzY
 eRVNMcPAtBXUwIZElJfQZ9a8hpbSdo8Koyq8X1wIrTmmXPewmjPDBxReWjG+PhKcmYoK
 7BRkFbS4i+cQhmBsuXHelj8USmENc8uV/PxbNBbVzShzKhKWaGFNvgI8tpgWSEjsSqCQ
 fcZU8jPsssBVu/e6DiQvTn/LYbqxS8GQ6vquGQsz2eSgGC+yLLqoPDSabyAh/tLv/o8p
 GAjA==
X-Gm-Message-State: AFq9FYKvkiPv73VXxdhnPqf4jP66yb9Ow9dbjS/RV45c+7KKeMr5TmlN
 30GgNT5LufFcCJqmbAraiDZdBU02Zu4BRMaqZ9K7/l+yDQmJGARlhjwgBVFBsNg/bk4T8VJfLFg
 yC6PykTfUHcUZTN3663LoO9uAmj5NihryJwZ4Rtz0K2H93vw96LWTUZfFGJAN6OIzeA==
X-Gm-Gg: AYBFou2iENhsy7+OOFLI3tZ2b4Ano6Kze+mGADPwTbzbrompTWulo/tQtdglZ44DM7G
 g2/8MwN8ExLrgfuoRyzwNSdE25WMF4EWIP+pL/DoneA+zl0Rjh6G2vNHsvg9YxrLY+D1P2QjAt2
 MfJnOUaL8FbwTwECc7kZSNTdp0eSrQdAlod58yJ1eC5frvLhps6yEWFihkioFcsZSNQEUaNYXNA
 ka9bkH2vLZvzyPKYzY+/w34dIlFLemji+TFILNzxrZvRsWom2VW2YipiOE+U7TNykjBd/ars5LW
 IU6R/FUSbOZKYQD2Ycz3EEpqLbY5arDN6EZqp+OdwMG2xG9YbaygG8bm1XxiVw1nhl+smFYB0Wl
 GlNAV1HOmtHwNtzG4KaTF+OyIf6ZOhgvnTmds9N079bYAxJWDXsOkQOyjZB0CW0M=
X-Received: by 2002:a17:90b:4a4f:b0:3ac:928a:68ce with SMTP id
 98e67ed59e1d1-3ad64bda54cmr186736a91.33.1792445239844; 
 Mon, 19 Oct 2026 14:27:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4f:b0:3ac:928a:68ce with SMTP id
 98e67ed59e1d1-3ad64bda54cmr186698a91.33.1792445237675; 
 Mon, 19 Oct 2026 14:27:17 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 14/21] hw/core/sysemu-cpu-ops: add get_note_size
Date: Mon, 19 Oct 2026 21:26:41 +0000
Message-ID: <20261019212648.154493-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wbKt_FN-LTNHjjBqUWu4DHG81gwJ1R17
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXwOeOK7/sFWQo
 Hs6PFsWfE6oUtYPiJnY6LBl6OEEPjUmYZ4jWOTusQFyNeVgR8HkVWPElb2lKrcayaeE04+mhZTF
 i1XPm0fu5J44Ba22Ing3bbL7PihjOu0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXxApAxC9r+9o8
 s4cfRrwGozzQQTGpFODrGl618qdX7uenQNXUDjapFrG9LKWYScRWTDTynulUmfMn716vA8BJMRp
 2SN61yDYi9Hhu8HhfbNWrX0Sj2ngJ+Vlg7+Jvxxv99LhKc+5yri7l2xbjwG80pgGaeG+w03ihPz
 xbGgDyHMpWrt/2JtdcsOvfS+0SkLdhkef29efQYGkCzf8Sfd2XMYwvhIRtpmO+RIWm7I3+XotSW
 xgBo42B650c1wG2ct67J57u4VcjebYE5X5LVCloKzt7LFAlD0KksYlrpXT6xki0xAKcKIZ0HI3D
 ZNvcrFAvqCIfGcAw1pNBDZLFseHfao0vU8qwHN597eE/7QlewNFAxNc2HG/bQuU6W+CA8FHVxDF
 y6NL92PSHuoON1Qdy/BMGz27u12RCGIDeghJWGzexAe+5gvFpSY5fjjK76NLlGa2F+sYKYkVds9
 uKCZwMqVF+5TwDfn3oA==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad68b38 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=s0xbLSvG6KTaNPbiVawA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: wbKt_FN-LTNHjjBqUWu4DHG81gwJ1R17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This allows a specific cpu to report the size of the ELF notes it needs
to dump its state, alongside get_dump_info.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 2c7d0b94767..1ad482f9685 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -100,6 +100,13 @@ typedef struct SysemuCPUOps {
      */
     int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
                          const GuestPhysBlockList *guest_phys_blocks);
+    /**
+     * @get_note_size: returns the size of the ELF notes needed to dump
+     * @nr_cpus cpus, for the ELF @class and @machine reported by
+     * @get_dump_info. Must be set if @get_dump_info is set.
+     */
+    ssize_t (*get_note_size)(const CPUState *cpu, int class, int machine,
+                             int nr_cpus);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.43.0


