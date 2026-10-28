Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE2606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=etc++P4Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GLrwNdxo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9I1-0000p5-KD; Wed, 28 Oct 2026 15:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Hl-0000nc-8n
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Hj-0006C7-4z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIP6AV1026455
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G/Cg/qul++lJwWq2udvUKq0hmTw9IcaX4vn8ozllmEo=; b=etc++P4Q7kNoXyhk
 2ttvrOofvuh0Qs++geOo6o9+SfL6foywaDtzJ1ouN6cgRtd1YNjKE6boWuztYhPd
 i+n2PWpZAabOvQclSaXW4h2FxICgvnFYEtvDfVyPzaxnfgfnC0AKLgtiT+P0CwDy
 EGeoDqfvPnDH45Y13jFHRi80ug72HYjS+5G0BTfjgdnPAm8AFpC2Log9mj2nWoJK
 mszBBEnt5S4k2f2FkYOD1I1k2U28RSoj8MjLmkq86Lq6pzIsLltemXnu7P3Z3wMs
 d9G78uxSwoGqYPGyzLbcoDwFNURkr9jn9QCJVbxGDL0/R2VDS+Gq3NDvaMscD/ga
 2JEqWA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb28gkv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e92aad34aso251187385a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215563; x=1793820363; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G/Cg/qul++lJwWq2udvUKq0hmTw9IcaX4vn8ozllmEo=;
 b=GLrwNdxoP4fpbOiFtu7qng+BWn2BHQuy1q73PFnEzE316Rrflt3R1Dqvvo6YLrDDMy
 5JMfG+wffpFBQhEm4Rm+UpdAKExuMzTQ9bo06CmpxNwknTEN/mUbl6nlZIGhlA2uZj4P
 Tefk+owNTWCakDrM8YDIzZArZXeZ02kGxNgxI0/3JjHE58FOxzpn2zXy+FwN0yjabSfB
 eywxXIz6ePshUw7hUydBjzEe0vSNMMemQjhnp2tjWpWYdtbdbB4uMBe48HkJRIPng0aP
 Cwgfg8bOcS2bFq/lXSaU5e1wOIKOmBjL+KLh6D+JIIhPTuadxeMZhabbjVMlMC9OP/Ug
 Rziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215563; x=1793820363;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G/Cg/qul++lJwWq2udvUKq0hmTw9IcaX4vn8ozllmEo=;
 b=pdQ2MHVJUCMXJPw5LAruochoMHrfnEiFJcO0G9aQ5box7CK+8BraC89yfJ1UcR8xqS
 y+gfefQCVKxW1eeSK5wBUDFlBP6mc/zpe/8gvKWEsTiANa5DPoySvMgKCE4NPaYzm3I3
 mVHdg8PlEyWTTKzrGufuMt8HjuVXqhqhowAIn3SR7F+tZtP7bkl021FiXWfenNNF3vVI
 a/MuaPPOchKMlimORHqTFFznI/wSVap0HQCEJht8E5IB3zJJ9YEXfTLr0EFzYhM/Gd+W
 4UxyqkmC073c56c6cwB2Goz05N3jS45Tw3FR+qJirxTLypjIJ5YzYzALPB/lsdqC3XV8
 osXA==
X-Gm-Message-State: AFq9FYKfPa9Y6uIp+aaQnf8Y4Tg5HTdOO6xMqEdCaGDd1KH4ucdNuVxX
 J7wsxo0vttzJaHLIIMkBcKLA3o1zzFABfqrzxVS2eyGe+HfnHf6dgXAbLhL4WSnwn0McVzmSp72
 d4Az7gji8BTBlmYi7WSoBMKp/PjLZTphXC3N64+JnBKQO3J7qE0f/odLtqif+Bi4PTTMP
X-Gm-Gg: AYBFou0GWDTvgInNsUG5R3WKekhuQQnvLpN76HZ8C+a21TGH2S4x9KI3soAQw3NPX9q
 BAv0tpOzxR8hrFwNm0qTd+R4mwXFQa9aaVam7mrSCeXMXCgBZyW1yGmyrgtoIvjCE0dqSvSZ0jq
 1DByhlJBhdrDyeBj9YkG2TPl6NQkmZxOy+MmBoRZp0KAQX1OSL7huE6LVjzHl+RvEfKN3+5is96
 vunqfzL6eGxA6g9GvmS3OtQLK2tU7ooVeTszwnUWZKpU03IOHWWCHAFNiPwy26kX4vAOMq1XV1E
 9JVKhBKPbvasMWkbdaVrDIpohAEmOrol6dIbE19SydhYajy679sykigwbvDlA6XAe4YYdTQTXIe
 BZv+7UmUY4PiFhURzjsDFxaOXVfJdYsMqimbajb5ExOGotZmMt9r2Kbe1YeFYQfPNxA8cgOFqv/
 ptUKkzXCGSLH2WmYsALk4t+asNAiy5lg==
X-Received: by 2002:a05:620a:371e:b0:93f:309a:ba5 with SMTP id
 af79cd13be357-94408cbd0cdmr538525685a.47.1793215563416; 
 Wed, 28 Oct 2026 12:26:03 -0700 (PDT)
X-Received: by 2002:a05:620a:371e:b0:93f:309a:ba5 with SMTP id
 af79cd13be357-94408cbd0cdmr538522085a.47.1793215562929; 
 Wed, 28 Oct 2026 12:26:02 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f3229dbsm11821895e9.1.2026.10.28.12.26.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:26:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 3/9] tests/guest-debug: Allow placing the binary within
 system QEMU args
Date: Wed, 28 Oct 2026 20:25:31 +0100
Message-ID: <20261028192538.31600-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae24c4c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=wiTerdHo6biFFVagaWYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: rkkQw3jNx1BfL4JX8GMvrKR1Asnih4dU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX7fDYTyRIikeq
 9T894cs22QRS801CnEFftIqvyLdO9FSXxWRrkL5y4skDfosxh1jXQG2m4TK0F9hQpYQDe7GPU76
 QJ4BC5mBBSStsNAD3C+QByEpYs2dAmY=
X-Proofpoint-GUID: rkkQw3jNx1BfL4JX8GMvrKR1Asnih4dU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfXwZFBeYK294uO
 Q/WrE/tSh+3G3bXM9ysZN3uObSuWV1JoVE6ZwgSIYj91posmK1hxNmHcnJ6S1QXqUe/Rt6fMAsX
 rV4ErXIFQqFtYBZLrufxCvip6yLnVpdwvIVGGv/IjuZnznbyytpHD4DENN4mpR76c0Jx+1Sm7f1
 nbFEBzhNNuyg/n4lN3jQzINlGXSjgSN1T0N0PSm1tUyEkn56L0Wo4YJx6tHBZab0Uaurwwn+7ah
 AIfzlN0ibH59y3+nI0IfsT0X7iC7lcsJdgoESsATDwgX65A3H1mHLer0hnaC0AU5VCTq9SfmOxS
 l6FGXmetAtTN+blK3csR4GtiIlFFaWT1zbqDIhvBbrMUTda+clbSXlkNJLRcnyKSRQel6AB1HNj
 YrgNcghL3tP+C4v1Kxe5LBAR/rUmXBDWps8Vyboa8QefOaMn0FS1bxIg2cR7p4Oy4eLRUqNNx2z
 G+3HKyyanHfsklupGvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

In system mode the binary is appended to the QEMU arguments, which
must end with an option taking it, such as -kernel. Machines without
-kernel, like 'none', load it with the generic loader device, where
the path is part of an option value.

Replace @BINARY@ in the arguments by the binary path if present,
otherwise keep appending it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/guest-debug/run-test.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 9fdf05b55d31..e6911300e8d0 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -87,9 +87,14 @@ def format_cmd(cmd):
 
     if "system" in args.qemu:
         # for system mode we assume qargs has set-up for binary if
-        # indeed we have set one.
+        # indeed we have set one, either ending with an option taking
+        # it (e.g. -kernel) or using the @BINARY@ placeholder.
         if args.binary:
-            qemu_cmd.append(args.binary)
+            if any("@BINARY@" in arg for arg in qemu_cmd):
+                qemu_cmd = [arg.replace("@BINARY@", args.binary)
+                            for arg in qemu_cmd]
+            else:
+                qemu_cmd.append(args.binary)
         if not args.no_suspend:
             qemu_cmd.append("-S")
         qemu_cmd.extend(["-gdb", f"unix:path={socket_name},server=on"])
-- 
2.55.0


