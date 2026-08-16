Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6FEC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcBn-0000gi-L9; Sun, 16 Aug 2026 10:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBd-0000A9-US
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBc-0001aj-AG
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlSLA3162140
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qPBKFiugEaEWe8CctXr0x4TgVEREe8GgPnN8a3uzTRw=; b=EmjRgbxu/SzLPu7B
 iSmk2y152LzrfCamOeqkywOMBTt98O0P4/piE1NwEVYmH5yIsm0l05ZOHOaX3G4A
 3Ddq8n96aDHu6S/QqHzzVuqI/V5Sg4TaF2BEl/tkJPWiJWMiK6/xCud24FQlFywP
 meL5a7nNm44XJ/gJHUOaCQD9bip2/WRZ6zzG9RWDGxhwk25oBcFz53wexd0qw0pb
 TSyuyobCxMXOgV7qWPjoTxhbAU8k+woduy4p4F4Ss1d2hqbAgKwOpynNRHx6Ely9
 JUqH6s1qPls/ErNitnmCM5YFUm1ahafasl0ysV6gUF0B3abiAkJ1nbGAuFSp/zGG
 bnIGBg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7ug5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9309af14fd7so208585885a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891805; x=1787496605; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qPBKFiugEaEWe8CctXr0x4TgVEREe8GgPnN8a3uzTRw=;
 b=jGPBAWZ8tq3JnplPY4sGUndYCnirGiC98op2T30GTOMBsJMK//39kwXy/Uh4eb7dNW
 TT7ymaSGTFDcc84zPwCMjIPXbbDYwQt6TtcXpyJsshZBono11ha2YteC/+zZafOeIeK+
 cTaayndeJceBSpozdQvbpZ1LuOfjjt36HYep2CbHmjaJlS4efEpYVJd+Oldc7vIIEq0v
 KhoC8SXwWicSp7jGIqtmdZXuTHY5tCAe4SpLcdAG3qXmwaIR6XAS/BTF8/tYpIXED5Zj
 xGo5UklWcHF7k4LfF/56SOFDw7bhNCA3AuEmo6vkS8ZVwaGsg2eHl/dBTE4YSrhf1+ss
 YY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891805; x=1787496605;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qPBKFiugEaEWe8CctXr0x4TgVEREe8GgPnN8a3uzTRw=;
 b=GWYFbx3d3yTe5GRQVpp/GhKPNAnXHYuRFdmROh+tBYH56uWUOw55zQTevopMdzBxoI
 /5Nb0aJYJNzzuJSGV7YMBsocGdmmMJ68hWvooRuhwZIlPCOkl4/Of+5j3Z1lglSZkZJQ
 7Zc5rSQB0ygdhWS5qnxhN+1ijlTOIv0r7DVQaLIySeR5Df2YMPQ1R/sQHoxRmrGFgXI4
 Jq+s8gZfh7/0UsUVVx1yMuPV3c0ZOGeYFjWiN5GP4ucgXa2EiCgn+GZyPHalbqIm9XI2
 pf5FDBHfzNbMMOjN3HXuSalj9MHWJRgyon23KFAJIZaNqztAyv2jbauyZmJnZDG6Y9Ji
 86pA==
X-Gm-Message-State: AOJu0YwTHvisXFf4RTOy0sNNv7BdqzwQ0fkNN+cLRSIFuft0aE1jCGhX
 jBzUUHsDwb9Zcqsaf6H6My59CvfFYmfeqvhjaY28iiCCfxrGPTWef5yCw2Z3a3INMo+DlkGR79t
 KuPFCxtSvAjB9pkzw4EgMMZM0qq9QawwtufTVf0WmNqlfqtMZxV0uTaWDo7IgeS8o8g==
X-Gm-Gg: AR+sD10v8dT8F2ZvJ/f1TImQ1f+8GsB+d/R5cFn5L4nMQrwE6zs6xh0Gwol0UHzacLE
 CFGI5WZ4kBH00XlVw8g73aJ2la99xt/OHhl06afPkZeFTVB3FzaJ+wkin9Ywig6OxsPCSHvAnt/
 k+ZscDwRqAOX+QJBwgSMDfWX5OuTmFUswii2Wugp+957xEBB+FQ7OmMWtopt0CXkq45NHdIYWwe
 4R1do6QvLZw3aA1U+GSNjN9JF8d5XNdx7IV+S1FuwqQ+HNFyy4KbPiYVvnvfKO4DDm6wP0ia8aX
 KTRqUJLYuP4AzhlhHJyv6rOFf8t2Nat8eGcGksKltgEMVFecZT6wXypn94vdUjKSXL+LWIO9k9S
 XwIy1lOHuE/B38P2b9tiqSzsQlEikXRB8KpD8HgN/5Q==
X-Received: by 2002:a05:620a:458c:b0:914:bb06:288 with SMTP id
 af79cd13be357-936d234d878mr2038744385a.22.1786891804932; 
 Sun, 16 Aug 2026 07:50:04 -0700 (PDT)
X-Received: by 2002:a05:620a:458c:b0:914:bb06:288 with SMTP id
 af79cd13be357-936d234d878mr2038739885a.22.1786891804465; 
 Sun, 16 Aug 2026 07:50:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f15b946sm25771705f8f.0.2026.08.16.07.50.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:50:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/56] hw/nmi: Use object_child_foreach_recursive() in
 nmi_children()
Date: Sun, 16 Aug 2026 16:45:28 +0200
Message-ID: <20260816144556.69009-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX2nKTeKzdv11/
 9sm1YPN1DrfKajUlTp+c428uScBF9LH25DtEasq/wCLBRofouIwNbKQJfRyLmfqaulcyPvHoVWf
 yFwFQvBnMy48A6ijkJmS3blmCmkRLcjLTfsSwpNowmDK/juJq62iWP8A5yXhtjXKZiuoYlSCAXL
 rqTQ9mbd5Ot8wYp86tvFNasKpfvm7A9EDreLSw14UfsDXPDHAUdJhD/RYNVxZkT4GCEqcMovHE7
 sByOkdsgMX8oezbiuGtMXHrJuryIHWU4Pii+hajQmIxKaimLjfu86HiannpU7Cz3oc/+rp7OfM8
 HPN40OzmjwE7FyjMGDvZZ/lXXZy3VItawAD/CpL9PPJdtlEATklYBLQ3MmaHEe4eGsvOvl4yv0b
 zCZ0XQPf10PbJtAwAEbw0t/SLJG1jke9fvByzWv66nKhfTqkBbd8htwurFlAP5kl+D0w8ygLtDk
 0nDqGCMAb8fGetqghFg==
X-Proofpoint-GUID: vk7nj7ZKhYJyYHvTze0gxwqXikbSyuJ6
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a81ce1d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=jmNSRpmTyL3U9imlh2kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vk7nj7ZKhYJyYHvTze0gxwqXikbSyuJ6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXy9MHmP9fNBzm
 XF9L52VCgHV24cSlikXMhnzL5RC3lkyrFEfCawk/AYLMy213EPkNgOYqrh3QSmEfnTcJUOEvYOy
 Ba0W+4PeSTyK/whBvn26iEKgErqI4t0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace object_child_foreach() and recursion by a single
object_child_foreach_recursive() call.
Propagate the returned value so callers can check it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812121232.71958-2-philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/nmi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 4b447e126ba..22724046575 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -31,8 +31,6 @@ struct do_nmi_s {
     bool handled;
 };
 
-static void nmi_children(Object *o, struct do_nmi_s *ns);
-
 static int do_nmi(Object *o, void *opaque)
 {
     struct do_nmi_s *ns = opaque;
@@ -47,14 +45,13 @@ static int do_nmi(Object *o, void *opaque)
             return -1;
         }
     }
-    nmi_children(o, ns);
 
     return 0;
 }
 
-static void nmi_children(Object *o, struct do_nmi_s *ns)
+static int nmi_children(Object *o, struct do_nmi_s *ns)
 {
-    object_child_foreach(o, do_nmi, ns);
+    return object_child_foreach_recursive(o, do_nmi, ns);
 }
 
 void nmi_monitor_handle(int cpu_index, Error **errp)
@@ -65,10 +62,9 @@ void nmi_monitor_handle(int cpu_index, Error **errp)
         .handled = false
     };
 
-    nmi_children(object_get_root(), &ns);
-    if (ns.handled) {
+    if (nmi_children(object_get_root(), &ns)) {
         error_propagate(errp, ns.err);
-    } else {
+    } else if (!ns.handled) {
         error_setg(errp, "machine does not provide NMIs");
     }
 }
-- 
2.53.0


