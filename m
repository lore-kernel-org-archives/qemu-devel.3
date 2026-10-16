Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764D5CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHjvw-0002AE-Nv; Fri, 16 Oct 2026 11:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xHjvu-00029y-To
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:33:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xHjvs-0006Ab-I2
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:33:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49e73611928so7346035e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1792164798; x=1792769598;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w5pljOK7VBReWWm9rz7x4eqsMiEU2DOOBJTRT5WZJok=;
 b=niQ/4HZRTSphkHs8zHM6D+s8xVKI4zkgAUswZ1KpEktMpwnybhovJeSEXLSajT9FJs
 Uo0ZfCPnpWHbG1lkCDmEldS85r9tC+gjCOrNYa0+Lf26VRNphHv2OFZuNOr/T6Wd9PIj
 t3lB8fgyWcWb7htkDKLtoBC+iYJXCNBDXIFrYW8ljYoCip2PlD+uXZgnOTqRq5cSSWVE
 Es3Z9Gu0rV2duuoIAJ/s4+gN6cL+hHLGZIBJg9PnVLzDF3wMp1munHNRuOBDYs9E2Hz6
 bmjT7JK7TNu1nNdd8H8ZAhmSwq0f4tEsYqHRVmPWYLr/z2HnsZTdcypbC66W7Z/T3DOf
 Uv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792164798; x=1792769598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w5pljOK7VBReWWm9rz7x4eqsMiEU2DOOBJTRT5WZJok=;
 b=YodjV+MgCwdTe4lKooQNYQXK1CLDzfDqGl7PzeoXwSfgXSUVOChSY5qHeV2r1NKr0X
 RcYnoB9fCL2vF0/xTi5smnmByoZNmngFzPvZ5V+C0NG9YYxQ17uL4jJGOH1xRUhpn6dB
 cPF6gT4tdefnG40RMegjEPbmzDYW6eNpDKDaU2E2tGbccN+vHywYTniB+bRPqQMt/nWq
 KTr03lNm3knAlszPMIL41vXAyLTOdJDGEVzw9HTZvu1EPif6yhBc2SJ8Lc+Tz+juIL3e
 4FBCWQNu/ljM0gawl2t3trmlgIg+NHwSPBfx8nLRGWPSz81j+67KvM89TnsIf+obKsPd
 KvpQ==
X-Gm-Message-State: AFq9FYIWVmIzhde2KJmHK3mm/naeIwvH7hV91kgvGXjbBEJRtd+Et3NE
 a0vHn/CzvRMbbH9SOcA/1DpwgVL8JSQ5EhAKof4rP/JQaskqlNzSkey1pdSZUP205LirdUlFu9M
 4mOuFJ+mYbw==
X-Gm-Gg: AYBFou3LvF8WkXsjX57VOj8o0ZnI1ofmU8rdzZ04G2Jy7hWPOLabeUi4grxD8NBgWZA
 TxhtJ3mWqOCwyQfmzCvgVGNq4+p15o5tQl9+/fBh+QQ2dIrR3JgxZYUEJy9xT+8GjXJi3GbbgXg
 HIti+bx3cxH5d78KEQQ8ANyHgyHnrnTMeHg1cCjEniZlpU/msVDTtdGcMf1z1IoqkdaSszyZZCT
 +J54Lh4MOFegzkTXTqc7od38Cv1h4EYGloGvWTublALhwYgPytQueFw7hOLWy/r8sBMfVoAstyV
 0Z7jQAoXdQwsCuA33OzPgCxLoaUWx5YsHkqOYi9p94cT9g1hpVEpHfu/WwVzLu1msj3RT7h7Ns+
 Zk6bu9hSn0q9+dKoqGUJSjMkGn8qapoodE8l5snt6TcRCPqkZ8Rb3qY+OdWv7prMtJYZzCna6Ez
 8TzhpkdyWKJsSoh0PQne/8paBzQvQFqO5lPQ/M3J84m3tGvPu4PhJYokEt6vyGH88/s4WqF3K3a
 CM5l6gEXOokScc=
X-Received: by 2002:a05:600c:5487:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a1d745f91cmr5673065e9.0.1792164797982; 
 Fri, 16 Oct 2026 08:33:17 -0700 (PDT)
Received: from node-dev.home ([2001:bb6:1895:f400:a5ae:413d:74d2:36a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd96f9a0sm156171575e9.1.2026.10.16.08.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 08:33:17 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org, mst@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Date: Fri, 16 Oct 2026 15:32:47 +0000
Message-ID: <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::333;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

A gentle ping on the series, patches 1 and 4 have Gerd's Reviewed-by;
patches 2, 3, 5 and 6 are still awaiting review. Could someone please have a look?

https://lore.kernel.org/qemu-devel/20260929202358.725310-1-weqaar.janjua@packetfive.com/

Thanks, appreciated!

Weqaar

