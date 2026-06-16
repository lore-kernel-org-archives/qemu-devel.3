Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A41CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZO3W-0001cF-9e; Tue, 16 Jun 2026 03:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZO3S-0001bt-Ch
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 03:17:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZO3Q-00050A-KK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 03:17:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-461a15cce0bso218802f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781594267; x=1782199067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nVeI2v4C82p/mQ7wdzkXLhujf6ssegXb8vyNRZ3I5zE=;
 b=zrGvRkfgjaMGjjwPUWrU/54ETlA5byVE/ZKUeSBUwuRXOJRIW4l1R+JsPRw1gempjw
 M/yzZ5Y8b9F9q1lH6CrDxXsTdgb2wVoW0iNjqvCaIHGxo5s32ajShyVELHytNjL5qptn
 IMsEVevhKoqaT3E6HuVrU95kchOouGk75w5K3hmR1RtbRJ25t/3QohizSuLCc2sL/Nij
 QEhmZoNKRULFRELoByTG46OMyb/2HmxmfkLLy1/gLHPnFe8AJNFB737IyBdfg9/VhFLZ
 +BO3uTK49O0Y3MebIYU9n/uVeDFFGb5QKxujTuf81G0qUNAvaNTV1gJ7++EI1Dqj++us
 xqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781594267; x=1782199067;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVeI2v4C82p/mQ7wdzkXLhujf6ssegXb8vyNRZ3I5zE=;
 b=WqxiLEAlCufWvqsxO6y5w4t7oO1qnQ1lPZNp+MoRhwQXLeoZPu4WXzy1cCTOOzbfn7
 yuHXdaU1LuTwBwmgXY7anLFu1rp4bn/Sr+hftJQ912AqExbuGbas/iMBrmUgQi4ouVRf
 zP8GwpFBn9j7lyNuXGPD1zuoUj+/HHlk4rLMQbgi/uicWT2UZK5l63Bphyeh9lKBmUZw
 dKYWBOdulVWbXKSMYWr9w7/beKV6RF7vXfRxYmSbbX2gS0ltFqLqW4akHUb+ftCz2ze9
 uSw3kMzp/UlG+a7Ps1EBPD151rbinPkx5OdY6cW8ilunNvGv+bBXEdb14e+0x2KEtuKy
 HHXw==
X-Gm-Message-State: AOJu0Yy2hh4YxZBql7aiUSOOpDBRO2AVOMxdMa3/fHGCR9AYmOHMykLf
 BBAf+Dd+TrCc0wR9gdvTioc1uLSRBZd4Nf67uTzBGoxCzLHljx0NC9V3poWXn7zk4bRbdrOH6WH
 bgEEXCVo=
X-Gm-Gg: Acq92OHllP6mIRCWeuRPX/9vgymyRnJ4pflSzS6tvQFVzGVLtmweM2MOISfrt3xmQ7y
 UFyNJChlY/g1XE71hueW1KDs8RgVzaXFTL0UhEV5H8SbICMO5Mmi8CfagYo4ycKpo9tfBq9aobc
 6yPwJccQqTYzoF2TXmv/sOw5UmMy/bmDxHF7kNZF/UDVYWaXdMQzyX70R3DhsG6JDX6mfswJbwf
 /bWcWYZdBrOZSQOmYmZGV93TcWmChnFn2HZBxqFPkBUM9h9BT9th91r5ddRY/fsiQz+C1ylaKhy
 oZWUxz1IaDFPiGtWXO00dqJ5Z1dyZ3hpQp0U9wUBYKe8/Hwq8QR64YSDmgDPVVAlyorv9AVAdEu
 +0QQtJXLYUFN3tU8TonwdX5ct74dHY4YVZpSPfY0YGhZxxj3gKATbpDdOtwdUKnd8Oj9OQwUUFy
 0yfSWxrjGSpSWpuLTt26u1c4lmzJWOwh0MiR+TibbBDsZkxsLexRKJuHMW0JrYHFFjDsh5mQ7Mg
 jOCQmu03LvpF4BXCAYRIMi2jc5gEdi91ZOSM1f8U4zM1gOK36dOsG3DPrCmootCiQfRCX5IYpeW
 YZu9ae3nACJSrx3VCXcqViRJ8rex2+f6YQ==
X-Received: by 2002:a05:600c:4e0e:b0:492:2e1c:1d19 with SMTP id
 5b1f17b1804b1-4922e1c1d3dmr69684625e9.31.1781594266852; 
 Tue, 16 Jun 2026 00:17:46 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-183.home.otenet.gr. [2.86.135.183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47ce3sm62438005e9.6.2026.06.16.00.17.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jun 2026 00:17:46 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:17:22 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v2 26/26] plugins/cpp: register callbacks using
 captureless lambda
User-Agent: meli/0.8.13
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615193526.2883349-27-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260615193526.2883349-27-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgpqxj.2ekvx0gczq3eo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 15 Jun 2026 22:35, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>We can now demonstrate what previous changes allow us to do. Since all
>callbacks have a userdata pointer, we can use that mechanism to move an
>object through all of them.
>
>In other words, we can now have stateful plugins without resorting to
>any global variable.
>
>As an example, we implement tb counting plugin with our cpp plugin. It
>produces an output similar to hotblocks, with same performance.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> contrib/plugins/cpp.cpp | 90 +++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 87 insertions(+), 3 deletions(-)
>
>diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
>index a0bb261fbe8..006fa6de243 100644
>--- a/contrib/plugins/cpp.cpp
>+++ b/contrib/plugins/cpp.cpp
>@@ -363,14 +363,98 @@
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
>-static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
>+class Plugin
> {
>-}
>+    public:
>+    void tb_exec(std::atomic<uint64_t> &count)
>+    {
>+        count++;
>+    }
>+
>+    void tb_trans(struct qemu_plugin_tb *tb)
>+    {
>+        auto vaddr = qemu_plugin_tb_vaddr(tb);
>+
>+        TbData *data = [&]() {
>+            std::lock_guard l(tb_trans_lock);
>+            auto [it, is_new] = tb_data.try_emplace(vaddr);
>+            TbData &in = it->second;
>+            if (is_new) {
>+                in.first = 0;
>+                in.second = this;
>+            }
>+            return &in;
>+        } ();
>+
>+        qemu_plugin_register_vcpu_tb_exec_cb(
>+            tb,
>+            [](unsigned int cpu_index, void *udata) {
>+                auto &[counter, p] = *static_cast<TbData*>(udata);
>+                p->tb_exec(counter);
>+            },
>+            QEMU_PLUGIN_CB_NO_REGS,
>+            data);
>+    }
>+
>+    void at_exit()
>+    {
>+        std::vector<std::pair<Vaddr, uint64_t>> v;
>+        for (auto &[vaddr, data] : tb_data) {
>+            uint64_t count = data.first;
>+            v.push_back({vaddr, count});
>+        }
>+        std::sort(v.begin(), v.end(),
>+                  [](const auto &a, const auto &b) {
>+                    return a.second > b.second;
>+                  });
>+        std::stringstream ss;
>+        ss << "Top 10 executed TB are:\n";
>+        size_t idx = 0;
>+        for (auto &tb : v) {
>+            if (idx >= 10) {
>+                break;
>+            }
>+            ss << std::hex << "0x" << tb.first << std::dec << ": "
>+               << tb.second << '\n';
>+            ++idx;
>+        }
>+        qemu_plugin_outs(ss.str().c_str());
>+    }
>+
>+    private:
>+    using Vaddr = uint64_t;
>+    using Counter = std::atomic<uint64_t>;
>+    using TbData = std::pair<Counter, Plugin*>;
>+    std::unordered_map<Vaddr, TbData> tb_data;
>+    std::mutex tb_trans_lock;
>+};
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                            const qemu_info_t *info,
>                                            int argc, char **argv)
> {
>-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>+    Plugin *plugin = new Plugin;
>+
>+    /*
>+     * We can register a cb with any function, which may be a free
>+     * function, a static class function, or a captureless lambda.
>+     */
>+    qemu_plugin_register_vcpu_tb_trans_cb(
>+        id,
>+        [](struct qemu_plugin_tb *tb, void *userdata) {
>+            Plugin *p = static_cast<Plugin*>(userdata);
>+            p->tb_trans(tb);
>+        },
>+        plugin);
>+
>+    qemu_plugin_register_atexit_cb(
>+        id,
>+        [](void *userdata) {
>+            Plugin *p = static_cast<Plugin*>(userdata);
>+            p->at_exit();
>+            delete p;
>+        },
>+        plugin);
>+
>     return 0;
> }
>-- 
>2.43.0
>
>

