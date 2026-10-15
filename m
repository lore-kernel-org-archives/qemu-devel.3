Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D249DCCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5C-0005Qz-PM; Thu, 15 Oct 2026 17:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4X-0005CY-5x
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4U-0002SG-Op
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FKNhu63462811
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ubg2q5durFO
 uHAvaecXamJe8O1hKc6jSgrt8tiNEdAI=; b=ZTlEGBspgx0tvSycPgn+VxOHo62
 ElJRkOfn9iJRb/oCVnsODNd9NUEflwBniZ4YDjYzFtT6AJ/zw1vTpvwb59mdHYNp
 XOnuE5gEzzrEFOtJpx6i0ja/TL84R3WPtYvrAJPR5OHRr1s9+dKHPf/y+oA4i1zT
 ke7Ae+wIqZI5eK0UecYUV6me0qmwQszV8uTALXjvhsdmNt+JORhcEA/3ZrzCrjPM
 0nMZn/QExdUWqs+NLUi4WMlCB3RUIzUDAS1n0zET47eUzd9V7UYifWVePAdkaH9q
 jSoxOgCUwGa8VlEOH65e6cPhogTCmqvHnVYKeFGYvoYP+sjFmDe5Pj9OeFQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69v53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd0cf3b1c70so2080324a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099975; x=1792704775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ubg2q5durFOuHAvaecXamJe8O1hKc6jSgrt8tiNEdAI=;
 b=JLwqreHwd55kjQE98X5BeyLqNoqMP7AxKGirR/HJgvrJzaVkNfEmP72qVw1Z3fupON
 MW5DSZiBq3pnkzpkc0DSMMUTmALSz4INE+6SVX8EyiPbxTljkDmCOXVkhD0BHOp9XeRr
 r2169YyYwGMrJdgounFRFgfU5QIJoVj9nt3+Q4hQEdm9o3d1JHq+DdWP2id/MUUSOgfC
 GNbUWviuQUC1Ts/kNG/tQ5ko5z9OqLwJAejOEqTvNMMWR/3Q8FOwFUGw3g/J7jvPz6tu
 4ohO4fSgT3di7eLxgwbikBOo73nvE0OrdEesCWCDlkE6oJtcEtGeePbHv+3IRVF8+mOB
 amyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099975; x=1792704775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ubg2q5durFOuHAvaecXamJe8O1hKc6jSgrt8tiNEdAI=;
 b=vMCgobXkO16q7i0h9Npbk8CwxyBwgx/AOzCzsd8KKn/IcZYoxqT85MNRUHFN7R1MIW
 8HC8mcdu6py/L75qHF3u9so2If3DOcAq0stBYgU/Xu8kSyTgDUpgUmQd3mHStHY/uUKf
 MnvT+Pe4LPGfoVp5f+VFgkPx8gyta/DU3jNHWA4K4IQrHbdYv4OoSY0KKGIL+myW1mBJ
 d2UYGvQqky8apfzmE3EJD0waBJDDtdZywybmCGxFCFmQ0HVl/zLnsF5eXTtipA5CW56L
 V8nQN2ajD9jR+NYBr3+V6VnDp7IPXVHPc2wXBlkvN2rCGeWNVP9XDw9W66ARSa/Z4Kld
 BQRg==
X-Gm-Message-State: AFq9FYLG2XDDdEPEQQYbjoI/8FMFHWPVPsGyVpPdsvZ69nmb92lA+X6D
 BcpHPaH+IF3xh8W82jiTCBjT+AXjpaw+DUZZGroVDv9b2XhG4WBFKw3s0HOErDoT2kONwWxOmRc
 iCnTihBSMJpus47bt0QxP9O5EVrUYA54HXH+tONKiNW/yc8sZA5xNtqqu6bONF6tS/w==
X-Gm-Gg: AYBFou2ZXpWtOgcjSnzev15aVRF6yAtcFWuvc5gVbxbbUBXJyN0SwOXOIOVrFe9VDhX
 drGIYFw0dSLEZPQjdHfHVS0ZUhjsL/Uq1lKNaa9K7AnEEWOPKpy/zY2eN0PgVjsWt44q7CPZ8zn
 BXlkR+LoyTdW8rnUYXB6S5MT/KfCBGuwwhovuu2W6wOi4IysOay48QSp8t0OtblCK5xOwtoMqTD
 c7hnCnyLiTEaz2KRrrmS5AfrLNr4tFw3j60FeP7uDf4lKRqsz6khu+7rNM7i8quu72fEFt0zhuO
 Vk1kdQa9gRAGk/StIFJ6R1fxX4ccvx8g1aXgoTyh2SUd9vTFyxT0aiZKtN2pGeLqmvGYjZviAj0
 2RkoUc8oi6MQN+6ohVpVx2S9bDTgD6bHiuPMYhxO5L0+GelalDPRYVR1WJf+B1gw=
X-Received: by 2002:a17:90b:4ac9:b0:3ac:c005:cf07 with SMTP id
 98e67ed59e1d1-3acc005d046mr945102a91.42.1792099974747; 
 Thu, 15 Oct 2026 14:32:54 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac9:b0:3ac:c005:cf07 with SMTP id
 98e67ed59e1d1-3acc005d046mr945076a91.42.1792099974263; 
 Thu, 15 Oct 2026 14:32:54 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 11/19] hw/core/sysemu-cpu-ops: add get_note_size
Date: Thu, 15 Oct 2026 21:32:28 +0000
Message-ID: <20261015213236.157767-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PPWb7vwcya6SnVlTPjLGKzxzn6MkHdio
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad14687 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=s0xbLSvG6KTaNPbiVawA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: PPWb7vwcya6SnVlTPjLGKzxzn6MkHdio
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXyH7zQER1G7Ya
 KiIq7hQgcYCdG+b1nt2eMFgIXH0YqMdF8JFM0/Q5XbNrjmxN0JOwa7rS5inAjfpqNN3CSd4sic6
 QT3rl6suoRUMfpuKv1i4i/2p/by9iUKVB8Ehi/q+GQle839jmzVCRJEyjebcKA618uH2nw+AtpA
 4/EomnNdwB5SE+JRXVqyJYUzUlss0Pv1Bx/5sjCQy4OhBEamyzJx1j7uZR00OAO/p07oyR3X5pP
 zGDZ/CJyH0eu+3lmqY7dAnTtqiVa4aIthYTuvkYOwLivKV7L7kaMkmfkoIncRmGKpbdCvX8D79x
 uq905WL8fSoeauyLLoYmhROGqHS2L9XgUzBsnilOwPDHchdZBEu8/YNiEUCmyNaVj/4ifJSvrGo
 mjqOgv1fXXIll1oKtr81634UN5blCyg+eqd9nv7jMaaFT7/BtvxP3yJfJ6IrMqKJXnpd7JgZVmN
 YW/PdICsP8afr3we0vw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXwMsthzT2YXaA
 vlmmX6wRW0ZHFgt2+5/9ERzWvrQrEa821e+YCK4QrP09c3e6S4ZFAZhJIXrSL+TNU7T2em7x4l+
 UKX1xmlTXDLVCixlltdz+vAQCZ7YKwU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
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
 include/hw/core/sysemu-cpu-ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 0b6bb42dc2c..31f1674d324 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -101,6 +101,13 @@ typedef struct SysemuCPUOps {
      */
     int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
                          const struct GuestPhysBlockList *guest_phys_blocks);
+    /**
+     * @get_note_size: returns the size of the ELF notes needed to dump
+     * @nr_cpus cpus, for the ELF @class and @machine reported by
+     * @get_dump_info, or -1 if this is not supported.
+     */
+    ssize_t (*get_note_size)(const CPUState *cpu, int class, int machine,
+                             int nr_cpus);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.43.0


