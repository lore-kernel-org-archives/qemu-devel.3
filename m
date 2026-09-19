Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7CCC982CC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7qqy-0005C6-Rp; Sat, 19 Sep 2026 04:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqw-0005Am-Mo
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:22 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqv-0007Hf-3T
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:22 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so10095135e9.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789808114; x=1790412914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TfWtRMVTGUYok1dnpe7O4lkf1E1YGNiXpJ5wSK2yxSE=;
 b=oYGbmaNxQddPfVC2Vns5VEqpeY3DjBXkVwPwwjgDfsxYnH63oHFR0A1smxbjcbRsuo
 NCHfoAtZ3M6Dtet5Zixuu9mMWEctEv2s8r6UMGBV3JGBT5oYh7UZ6RsbL1NgzjqTVyKt
 Dhlpe8DIQgZiOkVeNj4CKZ9DxzTlUavBvXlmr9/THnzm1mKH2JXwNLWBDUFqeuUJ6HJ5
 V2jY/FbhPgz7evSTkDrsjDtKo5hzGyFhYdRO5ul4Cqb2ng7Pyy+GEuKS6+DF/+GyOV9y
 D//rQRzXg4Wn9p4JQdxRgE5HEjOnp81L/hCG9yoy+xDtXmdiC4ccWMDXE7oq2/333VwE
 tCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789808114; x=1790412914;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TfWtRMVTGUYok1dnpe7O4lkf1E1YGNiXpJ5wSK2yxSE=;
 b=Wds1Ka/nCBCYB8JAywQblrT03irdV2QFlbyr1JN7norp61f9d4Wf3V55aBNNS8TCtT
 ysz1+e2AvvgdYR8GjGUEd+ALxsm6aW/Urwe+yQBBeEl6SuwVSuON/vf+MQxqh9LOQbf6
 v/b48wLaHRo7k3u/njbUJU9TOsyCNPzWbpS7wtQEyHavx1ab4tN81soYZx/lR558lOry
 WyO9Z+DTVdI4YNF4UXAsw+Pcj+Dt/ZeDMCgw8Z0ESB2uQMUWFQmWwWaxHCyMS3hcgcOo
 sa2DNK8W0HoxH3AD/5i+RPovcAXOporfl4gWN1/ArK21gql+LHjIej/c6Xl8Urck9nR9
 mh5g==
X-Gm-Message-State: AFuF++k/RrVD23XlsWf0IFl546UxLDRvykJwQhcyp775yR1sB+g/jbEb
 MUaDqY8qYtYa9vD3Cwtavg/KUwwAc1P//MESfBbvsFnAJaz3kPS9hFWF8/SHI7C9Ixfj+DTtuze
 3WSuR7S8=
X-Gm-Gg: AYBFou2XTPXYxvaziR6lemfAPG6HZQK8aB2gWQsR7VSqep/8n26CCw1gfeUhqYhoz/7
 eAPjAik2+AdypeeozxqgBAl9Lyg9DZLVARJ2tAI8E+wP8k4yXVjQbhYU70JnFKjotCLdom2qz2C
 tPGNNs72oHHn2grB0I28rMecghljrZlBT0WFKL6J91NuOz2Xdfnhhl8Dx0KmP4k1oDRBDs6X/fA
 e94xQuOppW9GI4HWIF8tdTtE8iECeE4bwKn8yqe3+aEliMh+K0/vne10R2KSy4Y6SRJPvegypqv
 N7cRDjWGxYA9xzsedvHYllf9fD9C1bDY7lo+PHclfbxEeIw+Z5t76tkt+EdsnNmjq9qbsyAsHc1
 MIEWU+3B8NYPXcjEpeyyZUztm72UVtL6pCRNRAVT77lFRCvLt8HTh8O6gEaBW+MrhBns5k5kBGA
 gsF70W8GBL+ESX0Rn+Jn6Ga51G1ewfklGWLMts5y0y6aUqbrLqe0dXgnTW4N081ImJ8xjp/Sm9Y
 5fvtoUzUenWeh2ED0Z47Iwv+p5s1UcSIstwj2cmbAfWmunnvW4H+FhJcfi6kWZEbfi2SR8IYqcx
 eIHUwjG7eRw+Rd3yma3iEG1BYVcEpX3J+k1Ue+F25J9LAKpHuDMcKqtBnfRACP8sCpC//eZd5IV
 4PEyp42m8DCx5EsrGXN4FjefJxHSY/+P8wKfbzUlMrWsX
X-Received: by 2002:a05:600c:3ba4:b0:49c:fc6c:be15 with SMTP id
 5b1f17b1804b1-49fc57414c4mr84729675e9.27.1789808113800; 
 Sat, 19 Sep 2026 01:55:13 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58ce1ddsm82736875e9.3.2026.09.19.01.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 01:55:13 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 02/10] hw/audio/virtio-sound: drop unused struct
 VirtIOSoundPCMStream.flushing field
Date: Sat, 19 Sep 2026 11:54:49 +0300
Message-ID: <20260919085510.3388454-3-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x10.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260803081159.91981-3-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/audio/virtio-snd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index f8bb5c95b9..b60b098ccd 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -138,7 +138,6 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_set_params params;
     uint32_t id;
     VirtIOSound *s;
-    bool flushing;
     audsettings as;
     union {
         SWVoiceIn *in;
-- 
γαῖα πυρί μιχθήτω


