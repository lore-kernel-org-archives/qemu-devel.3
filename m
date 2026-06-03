Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F2BCD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsb8-0002i8-7w; Wed, 03 Jun 2026 16:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZt-0008Cm-I9
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZo-0004Ku-UP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653HWSPZ3552373
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=amhGlZw3DRa
 o7feJkWiGnFMlE8A3+ahtNigty8xHgWA=; b=lNWU4izE2HA2UH1bdwRqR2/QQQj
 4bWWZoRI44y8NFyOKzgSYigtmXM20RMVHL1Vx2Qi7x4arU3XTiq5kMuptpqD0VzO
 TKCxvyN+4yPQ5NMqNzD60Y5FszAEtGeO0gKhGLp/eKlfQoehsihv2lGnpj3JEuyb
 6rG7WNCp/8Gs+5bU5z7Vx0/d3rUPeg9zYqvZ0j49c3nBB/7BUt25DCfkUe1tIc1m
 5l18FkxNIQLvchUf66kwFu2xbm02wEueIW1IBrBZlYtjh6TNbc+mRBXhsuR4hfJl
 qP5NplqTjT2Cpg8Myax0CkuzlgAwiBU63SkcCXI4nZ5y2yEOzsYvQfMadDg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj9mtp36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:34 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304f1820babso359986eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519953; x=1781124753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amhGlZw3DRao7feJkWiGnFMlE8A3+ahtNigty8xHgWA=;
 b=SJQivX5IkXL1yQknjU7xzxekSq1G06G+ALZpdhwUTe+hAFU3/Yuel2zzg9KkSh2nC4
 6AeIugXl4NISfZ8dukjgyNXIOMx2YJRkqIpbjeAEz5FM4ZcEsPGvrw6zh2OUG6+w+NgB
 LxfLBpb6mE5be0i+Mla9eRTgQ5iY0sOcCrBKnao1L56i+UJQR4mrksdsf6UPAZrSzaAw
 5fDMd8/izDqm0k/swJAUH4sMBgYDTcbzqHv3jOnOq3QKndpQf8SrYf8lZoEaMu3Yr8md
 JLhHzpiZCDdT3+Z1i80aVWZ9UvwHVecjtg10ns6JfuMhl47h19dUoyE4Pd6ddgqHy89y
 lvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519953; x=1781124753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=amhGlZw3DRao7feJkWiGnFMlE8A3+ahtNigty8xHgWA=;
 b=hH/vLItj1IeInnbmrNOPtGNODB+K/J09E9XQL+Bw4FoC1bOdIIHNfFc9/y+ewiJV5E
 euFBnkRDeHOydTuj8RhMUv2+MONdS15YE+quJ7XyGLdAqt57xI12QkOxIVAvF9ErNDHy
 KLm30WboDdSnWh/TLr0crjQ5ZFiD439eMhONIXaP2CI8a/fbNckMt2v+f3IGTkctNTDM
 RtINYUeWKpYOovmzI3VffQPek6mVQ3o1kNQZAMWih263qwmAo+0oqkifOxMAPpTK/9VU
 ePpmev7sDe7e1Gyn5HcJONh4TykVBSCsRqqnUzu8WypB/LSbIbOWLw4XZ5db9oKASmCd
 Y0iQ==
X-Gm-Message-State: AOJu0YxxxeJAiyi1vOk1iLzk58TuCGVJYolrZgAcoK7ovBtSjcD2pHXx
 h77uDhntD8XRU8OvX8oSG2LWdo1kKImtjRc8KxdgwDYOPU0v07ogz3urkTItt20qES3koLpeU6V
 hEL0/hl4tSqOwOH9lvupBa6gLOKiG67z2ZBfYGM9dwMD4Mbmc3E/xNO4xHSOwmB/Cuzg8
X-Gm-Gg: Acq92OG7bhl2TTNRQMbCesbYXusYgwQenRInxMCwbQxhJsmxM2SQj43I6gU6pwbprpT
 +ecTNsuw7mCgd25GQWs/o3ENCSwW/5TrnhvKogk3G1ZKT0wmqNy+3AX2NrnEjpQKPCpXOgyVDrD
 jG9kV0pbt81n0J1YZe9BpD2WMHO31tzirWS1GIu9SUkB62arT1CnPe2/bHur6WRoHeUTHfnDhIM
 u3o9TCoRAXz+yo/zEjS2SBS6wIO4dh/zUgZCPFYaDye6g8sTJp0z1+Z+mvuqTnw2Tudbi6XHQtD
 HzJtA6QrpP2XfkwQBQ+yYAUIyy0/1U3K5oQu4hvPgdvRT4JfWsunA/Jlj6SEe97BvYAVHKhjSJB
 2Qx0c3ca8r/1cZzCPTP9A3YAvIIdBuQkAs2gKuneOb6y+Yo4LW9hM9GXTAzicHsQDhjRuSxrmKC
 WktqBa1gKSeYZZ6Et9
X-Received: by 2002:a05:7300:3c21:b0:2f7:d419:dee0 with SMTP id
 5a478bee46e88-3074fa6550cmr2676083eec.6.1780519953284; 
 Wed, 03 Jun 2026 13:52:33 -0700 (PDT)
X-Received: by 2002:a05:7300:3c21:b0:2f7:d419:dee0 with SMTP id
 5a478bee46e88-3074fa6550cmr2676075eec.6.1780519952752; 
 Wed, 03 Jun 2026 13:52:32 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 25/25] plugins/cpp: register callbacks using captureless lambda
Date: Wed,  3 Jun 2026 13:51:52 -0700
Message-ID: <20260603205152.1440291-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gxZWtS81N9Rmj9R9PglEEvfADGMS_vVa
X-Authority-Analysis: v=2.4 cv=XK0AjwhE c=1 sm=1 tr=0 ts=6a209412 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=4ZBAFY-vN_xJtpMkgcgA:9 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX7rz9Fv9g4l7N
 oh4HrH8AZVykBqUPd7mFAWcxrjZSFffapuil2D/QrlOhRLhzXsD7H+zSt4AUS5o/jiskCdKK7sD
 WDQWEEqY55idrskWYhsMRWXQ29QUz3pYJVO3NsqRMNsXrRU+lr6ZEEiPfuWRpX1G/rU6YXruwFV
 OKmCuVFyrYkpV3rwx+525SOri8MB/KfbTI2PQaQHjribZryn7aGo4DjK5BYM8PmJDK6SwuU0MC6
 sLzb5dSyIknwjjPFnweSZuTjHZ4dvz/TycunElyhYBF1e1hRCPd9xZBVT7X9o+oL/11XMEuU+PL
 HvO19TcqZVMv+cl43GJznCr5S4gZOzSwuE4M0+fMF2pCZTSqUv/tHOJ2fsjhDHxt0uMEd2dTE5X
 Ne7ktNXJDH2Yd5KvqzROy18W5Va/2gJbzcWWbjpSqQ8Bl0suBWgroLZ/uy94d3QWCgEcpFUWHF3
 DiA2WHd70GAhNLycvTg==
X-Proofpoint-ORIG-GUID: gxZWtS81N9Rmj9R9PglEEvfADGMS_vVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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
 contrib/plugins/cpp.cpp | 89 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
index a0bb261fbe8..c5099456525 100644
--- a/contrib/plugins/cpp.cpp
+++ b/contrib/plugins/cpp.cpp
@@ -363,14 +363,97 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
+class PluginInstance
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
+    using TbData = std::pair<Counter, PluginInstance*>;
+    std::unordered_map<Vaddr, TbData> tb_data;
+    std::mutex tb_trans_lock;
+};
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
+    PluginInstance *plugin = new PluginInstance;
+
+    /*
+     * We can register a cb with any function, which may be a free
+     * function, a static class function, or a captureless lambda.
+     */
+    qemu_plugin_register_vcpu_tb_trans_cb(
+        id,
+        [](struct qemu_plugin_tb *tb, void *userdata) {
+            PluginInstance *p = static_cast<PluginInstance*>(userdata);
+            p->tb_trans(tb);
+        },
+        plugin);
+
+    qemu_plugin_register_atexit_cb(
+        id,
+        [](void *userdata) {
+            PluginInstance *p = static_cast<PluginInstance*>(userdata);
+            p->at_exit();
+            delete p;
+        },
+        plugin);
+
     return 0;
 }
-- 
2.43.0


