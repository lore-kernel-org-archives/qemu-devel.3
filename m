Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AD8CD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYl2-0005Hy-6l; Tue, 16 Jun 2026 14:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkj-0004hk-Fy
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkg-0000VP-8g
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOeK23966063
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=i7fAeaaOPcn
 19y/dAG/sD8eZZ4gnfNsQjKyrEUqzSYg=; b=Sua31umkKBscSJEzcAbOB1DlngW
 xWMRiL9R7bodm9gujMK1E0meshlFNcLGS4o9RgwTsyvG5f6mKHVZF9O+/CWgVA21
 7ews6d/hppPp760akOLeRUXDCZEfv9fP15ajuPBExUVSRcgIlTj6HGTv5QhXia3v
 BUXP0q4Dmh+WhAC9vXoJBmIbVEsABpG+LTF+aLIiYqJddNrEtHOZsx25Xl8COAaR
 2dFiTtP1C7ZiT/ua/96OoJVEZC2W3WZKFK9VD4YtCxjzKNq8BLQBP6e6ZMPCOeM5
 w3GXlaoLSiCS7Gfhoj95dONoWR4hnG2mGetu5isGdNw5zncO3YVyOBGcz1A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etx8kc7yh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-842688fa7b8so132734b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635387; x=1782240187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7fAeaaOPcn19y/dAG/sD8eZZ4gnfNsQjKyrEUqzSYg=;
 b=YkkAFwS6L723ZCUZnRckJkEqKaYWGbZUu2+PNvB3NlCvjMls6ZwRzcoPw/3BQJEA0l
 ZLKoQjGez/wo73M7tW50u0DfOyrSK6qLIq1fCCB7v+wyRDKzcqlXZaM/X2ShCanerZzo
 jKGBtJaIc4hTunJspKAP/e8ftGCefemLLIFwC3kHjvBhi4KUPqS6MY5tyD2XHBZcCZq8
 h4LgYPaXCor8hVK+hTJfmrPDSgvjiJBaDQ/BSd29kpXBqMtQQQPGa2UVCXIb+IViF+5e
 bHu4GzW7+YHBBuOhR6RXQbMDF7srm8fMNDYoMZTiKfGo96KJGA//SUiFaIyWiX+kx5/S
 r9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635387; x=1782240187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i7fAeaaOPcn19y/dAG/sD8eZZ4gnfNsQjKyrEUqzSYg=;
 b=G/EdvDCSVoTJwdbco2krmma63kDcJwRKhNWpT2WAzgh89e3/sPPFacvHuIYeffHtZY
 rlub+5xiGm2Uijr1nJ96EHYDx7E8X8+/v2JK4jK7ONeoIenO/fhJABoRYAO2YABhlb6E
 LPLIf2UuP2dIaI5DoQNqqy7JoxdYj1/k3KLBf0/SUb0X/0pwRJbrnD4cVDSKEXfPyT8g
 IN7WDgoA0n+0lvZadW6x8U5ubbbUIZ20yOnZR29czh8ku9AMr3KaA7RjiKJW/D3Sc21D
 zgU204NEbwMLUg2XDABSgjP7ULykHm4XrAo5GG/U7gEexWrT+svJ3tIUNoqG5pmfxUON
 OfjQ==
X-Gm-Message-State: AOJu0Yy8yZy6W3mZXIE1ureL9r5rLvvCc6302nwbsnLk81GnJOSmbNI4
 Z19lIubrdTpUIjBj/oQtdF98Mdmfi3TpHuoAQgwkX6WOimeQxxSN5nYqQGxfLY3DIoVYRsdRVUM
 oR3zcqpp3KR1MEvK4lw3Wrlb0mLyXlJLgeieW1uQJzLpkiRcQNBxGfsnP81an/j3g8uSq
X-Gm-Gg: Acq92OEYfnTe6kZMRSLx8ue36D+rFXwHP6yPYMz2thcX/ZKRsb1Ur3OGfgUPGJokJBD
 NKX5fSB7+eFEfjTG/ltRGOYucM30uLaNDsvvbAuVWmjFoNYaTGWN63TqOmgbNClx2xUZDKwuJ6Y
 7MApix2HaWFS6gFa5RmhYF8vOZQkXEsoU7TXNN1DpXCPDQBaz44UqLjXNDGvVICRSLE0UVLy1DF
 rO70xXNuEx6GM7Jc9HBDnbs+uU3nner2w8cpn3iviOzl/gloFxGVwABXB+kjPIOV3cTWLfIarhl
 BgClCXEafsZ21eH8Voar9syh60AWdVsl+tG6lQJuT+0n2xcaZ7hiwWk6TFzlM2b9Zxm2dg/LE+r
 ScBJYwwlRdn1Eo0dGLcnWqeXjVKtGnIwDbGWURYiFXk7S1kmc482+B5PPHMS8ypgAJwI04vECST
 lYdwQ2oQc=
X-Received: by 2002:a05:6a00:2e14:b0:842:63f5:d097 with SMTP id
 d2e1a72fcca58-84513e0def9mr4363591b3a.3.1781635387539; 
 Tue, 16 Jun 2026 11:43:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e14:b0:842:63f5:d097 with SMTP id
 d2e1a72fcca58-84513e0def9mr4363568b3a.3.1781635387000; 
 Tue, 16 Jun 2026 11:43:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:43:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 26/26] plugins/cpp: register callbacks using captureless lambda
Date: Tue, 16 Jun 2026 11:42:30 -0700
Message-ID: <20260616184230.303038-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfX8vRxnoyWkcmM
 MkduuSq0kDsTGEDt8XDiIhhk5mbUQJ2+xQxEsfoCui50eVHSzHG1Y5cP4sAQkRHA+yjcrTAplJh
 1UdqTOfyQcFmE/tQ3GLWs31e1meZZnZVEFKcppmwwCKFHJjT0S8y8yci1V5KnbVvZNMVQWQYAqG
 4yPqdnvOmtzf5HMzxcH/23PtgnRT7Tq/A0Pg7dhpuL6x3sse2ttrRTWTqaPRS1jMOWohcu9UaSd
 nQ2AmZ7WQRCtI9Xx9PjYe76UnCFraOn2wBOjgasflT+/r1OD7Tk/kGVhchUFchX6yQ/Zwc8bZ6q
 yn5ZlUjOSyaMSyjiNgNbRcP+r5peBmu3yJ9aCuD+MNhb9DFX/vT3VH25YWF3SXuz/xfk0A9tE0w
 82RUklBUMAxaO27zUAVzczX8uNfSk5vBv5flUAmqbD0FqtQ/5iZwJbvjOMCHBx1nkYs0N8cLMd+
 5/u8BhVwodd//7fj7iA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfX5WNizbcf/nXU
 kMExdvVAsSXpMdiEHV0EwtpShZLRFC4jhCS5V4ATjwIQKwk6jzBhPDoyEJYld6RQznS/+AVmAUt
 3UZ38a0NDOhWhpl6o30WcLVCtlwWrTQ=
X-Proofpoint-ORIG-GUID: Pkx9U6xh8keS9nCIrIT32h6D5rj2NERK
X-Authority-Analysis: v=2.4 cv=dZawG3Xe c=1 sm=1 tr=0 ts=6a31993c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=D90kLAkOAllNM0JH3EsA:9 a=O8hF6Hzn-FEA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Pkx9U6xh8keS9nCIrIT32h6D5rj2NERK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160191
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-27-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


