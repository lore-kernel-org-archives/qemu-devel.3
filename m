Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5EFCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD7u-0004rY-KP; Mon, 15 Jun 2026 15:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6Q-0002X5-NK
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6N-0001XQ-UE
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:09 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx0083577885
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e0U0jPdf9DP
 07XEh4hlQkA0/lzjvbReCNzHoQnZaOE0=; b=a7zSyvvwav6BvjVkQqb2MnQ77rp
 P/kJXMPBI9KPbd6FxZT/TSZ+quu/xLAO7njUQ1aVcGayGGZmJofyPlntP+q9RHZy
 KkplDEOfPA/g8xqfkMCveEo7nXRX1SFUsMBe3ZNPixaoFUrus+K6DzaXlQCSW62w
 lm4ra8HecfDgxDyTpDM6ffbKTxuh68b3J8G8M4JjDusYj6Lv8ZRJbJoWtQ9kMF6w
 3u/PxQu9jG23AxhWTmET8PvVtgJn6U0YdNKUpv1b1XyFkmILjTi7yV2RY6snQNym
 ofwcvM/UM6KbMElGYJ74Zz+XszjFE2mAx2WFPFbLywN9WU5WWQ4OLrzFefQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete982s8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so5979790eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552165; x=1782156965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0U0jPdf9DP07XEh4hlQkA0/lzjvbReCNzHoQnZaOE0=;
 b=bYBF/7MrGg96E03ZqZPjp//8R4ahohodFLqtgrQGrSPeP38cXplWESF93VllMninSj
 TnJ4X0lA5AaHuGicOZbolxCrFmt85TVwMUN9FN774TeeFwDj7QdRffcf5O5xueKn5ecH
 szYL5t/F3RsxDTtD5n6ClxKbxz0Of2xzAFiSflEyV2sQPI5V9vjtFf6s4N68dFNCJZvZ
 tt4T0ICa9AiTi5ji5o9KN+C99gKe/pKzzIR556+9nsk3qeZCypukWENqXKTuNHFjdCi2
 Ui8IIx9bTVblu3EENJMi9mZh7gOW4YyxxSb97EJgREg1YjSP1PinRr1J/8x2WmPioFOf
 6XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552165; x=1782156965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e0U0jPdf9DP07XEh4hlQkA0/lzjvbReCNzHoQnZaOE0=;
 b=WsryOrWYduBY1F5ChXQayG40VHMEG0+oRQxgyCCdyzFv8n8YmedJNstXtpv6Adm616
 zIUlwjzdZOOb2g8dRmUib3cZYs1rmIMa2HcGnS50A8oxvVe6BzT9QGmA1KNHm9rkWJ2x
 dJi1NIpme6/VllDFZxHF2vz2snGDMKn6PYXgMaTMePcA418VvEXuR8m4RJ4iHgeGV1WA
 j+rjt6dAN0bfGhTMZQcOsIoRfIc2b9ogIN+kb/u3xyJ4e0rwWRPbxpN4f3miwjF79vZh
 XYc3RsoSBQbaofykSfbLACU4pJGgvnURa7LoLSthj7/iVv0BY/BU2iochgjN4DpEUMBT
 TaUg==
X-Gm-Message-State: AOJu0Yypv4wkLW1qEkpo7fIF9JN2WcAeHvKn8XavZ8oapAoL79Ko7ifj
 SmUXpAnhKR6GwMKeSmyjpfVs7CtjklvOW4/pJJx0RT9KwMA6QU5YuCjaR13NuOkKhOlRx561G0g
 Yn2T7SsHyRMXsN8OgTfGZJHN73tk0QmQ+m1TT1QPfwWkMQsyOl5UonUFoFYk/8U5N0W9a
X-Gm-Gg: Acq92OGKw4MJ1afw2SojGcwB1TaoCGDIIqz5kcwtXJz1jIZs3N1qepqYutJsck2Xxuo
 tz/a4geHF6jVzjxE0/Oy2KkqgVC/Mp24Ed/zupQRj2uqht4B9FU+QJSpeNs7Pmo62PO4eiWj6iG
 ZBQkiJkO1Lwvdsl7rYdlwxsmccLpJFyrZPm4UoKyW4kn9nHw0JFXcqTdAR/2TKEgit7Z419GHiN
 lQw5oZny5pU91+/pHWkbvbzPTWEpP7aQmoUiMSD7GdQocyhf8a+1FryPu0hXnZTFakIDJ6QwxBh
 WpNWIuAjd3iubqMDxtxOg8Giwnijc9qipJPr3zGdqgksDuBqhGrFmTSlqcfdOqCEDxujblTYpzH
 PLv8fvweVvPD/1JpqU+dFr3B2sf4Ykp+4+OEE6EMdvN3htC6ygGxnDVNCLfd5RVahcS9dEJn3s6
 ZCKldfeg==
X-Received: by 2002:a05:7022:6082:b0:137:ecef:c935 with SMTP id
 a92af1059eb24-1386f24a584mr5108425c88.5.1781552164518; 
 Mon, 15 Jun 2026 12:36:04 -0700 (PDT)
X-Received: by 2002:a05:7022:6082:b0:137:ecef:c935 with SMTP id
 a92af1059eb24-1386f24a584mr5108411c88.5.1781552163997; 
 Mon, 15 Jun 2026 12:36:03 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:36:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 26/26] plugins/cpp: register callbacks using captureless
 lambda
Date: Mon, 15 Jun 2026 12:35:25 -0700
Message-ID: <20260615193526.2883349-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a305425 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=D90kLAkOAllNM0JH3EsA:9 a=O8hF6Hzn-FEA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: epkSJmks2faW8vA3ISSSPSRFjuv6aydl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX3OtYO1BaJD6m
 FdIO8pHB3icHcK6QFfbSSRa+d1mneJo3nv1FpdN0oAjULcg6jK6dhdGs8KOLIpn5YB9q+mqjQp3
 1aFLfEc1vCQE76eov1jwfYOGDrLH7Gs=
X-Proofpoint-ORIG-GUID: epkSJmks2faW8vA3ISSSPSRFjuv6aydl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX0+nsCLjClhvo
 fW01a3vd90slP6IwssvMMPFuiPtE3vSx+i22kBnkvOHfzu4pF7E5zEz4UO2ok2Ei7nIwFopLxqk
 E2MevCwMJV5Wo1WPgHotPHnBfu7PMuDqaCkLlzww0OgyAOFpdxT+MACfPu8igSJdDvj+ljyp9KF
 JifHfIF4QpkhqGPHNv8BEL1Ped8Nc6LubHUkH+D1HMGjEOLy6wp7AifzvLy61xwqDejRaD4id52
 Li9WCLBbrmp1f9x/5W3JnEQ4aQ2bwiXX1MpQ4sm7CNENLZ6RPKWal+SDx6CL+c07DtGDvL88AYM
 +yaEnFm77+U2q6om8EMjEVK68cb3Z2w6XA98t02UGQw037Xu+No6h1o6rnyZmnSFhrYR27gyMmt
 OVRsiUW2rkSodbuTPmKWRtAYGdXpSzAMSskydtYsWjK02YtcTH+u1bexwXCKDnNUTRIcmWTu7XW
 yXowVXxe/J7UbzueVaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We can now demonstrate what previous changes allow us to do. Since all
callbacks have a userdata pointer, we can use that mechanism to move an
object through all of them.

In other words, we can now have stateful plugins without resorting to
any global variable.

As an example, we implement tb counting plugin with our cpp plugin. It
produces an output similar to hotblocks, with same performance.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/cpp.cpp | 90 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
index a0bb261fbe8..006fa6de243 100644
--- a/contrib/plugins/cpp.cpp
+++ b/contrib/plugins/cpp.cpp
@@ -363,14 +363,98 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
+class Plugin
 {
-}
+    public:
+    void tb_exec(std::atomic<uint64_t> &count)
+    {
+        count++;
+    }
+
+    void tb_trans(struct qemu_plugin_tb *tb)
+    {
+        auto vaddr = qemu_plugin_tb_vaddr(tb);
+
+        TbData *data = [&]() {
+            std::lock_guard l(tb_trans_lock);
+            auto [it, is_new] = tb_data.try_emplace(vaddr);
+            TbData &in = it->second;
+            if (is_new) {
+                in.first = 0;
+                in.second = this;
+            }
+            return &in;
+        } ();
+
+        qemu_plugin_register_vcpu_tb_exec_cb(
+            tb,
+            [](unsigned int cpu_index, void *udata) {
+                auto &[counter, p] = *static_cast<TbData*>(udata);
+                p->tb_exec(counter);
+            },
+            QEMU_PLUGIN_CB_NO_REGS,
+            data);
+    }
+
+    void at_exit()
+    {
+        std::vector<std::pair<Vaddr, uint64_t>> v;
+        for (auto &[vaddr, data] : tb_data) {
+            uint64_t count = data.first;
+            v.push_back({vaddr, count});
+        }
+        std::sort(v.begin(), v.end(),
+                  [](const auto &a, const auto &b) {
+                    return a.second > b.second;
+                  });
+        std::stringstream ss;
+        ss << "Top 10 executed TB are:\n";
+        size_t idx = 0;
+        for (auto &tb : v) {
+            if (idx >= 10) {
+                break;
+            }
+            ss << std::hex << "0x" << tb.first << std::dec << ": "
+               << tb.second << '\n';
+            ++idx;
+        }
+        qemu_plugin_outs(ss.str().c_str());
+    }
+
+    private:
+    using Vaddr = uint64_t;
+    using Counter = std::atomic<uint64_t>;
+    using TbData = std::pair<Counter, Plugin*>;
+    std::unordered_map<Vaddr, TbData> tb_data;
+    std::mutex tb_trans_lock;
+};
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
+    Plugin *plugin = new Plugin;
+
+    /*
+     * We can register a cb with any function, which may be a free
+     * function, a static class function, or a captureless lambda.
+     */
+    qemu_plugin_register_vcpu_tb_trans_cb(
+        id,
+        [](struct qemu_plugin_tb *tb, void *userdata) {
+            Plugin *p = static_cast<Plugin*>(userdata);
+            p->tb_trans(tb);
+        },
+        plugin);
+
+    qemu_plugin_register_atexit_cb(
+        id,
+        [](void *userdata) {
+            Plugin *p = static_cast<Plugin*>(userdata);
+            p->at_exit();
+            delete p;
+        },
+        plugin);
+
     return 0;
 }
-- 
2.43.0


