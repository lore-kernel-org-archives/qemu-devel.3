Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF261CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 22:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyHKs-0004lr-85; Mon, 15 Sep 2025 18:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyHHM-0002RW-3o
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:02:32 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyHHD-0008Rk-0Z
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:02:30 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b0411b83aafso706120266b.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757973731; x=1758578531; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oTQZvVdeh0u2lyFgzlwQ4yWvPSR7Q3p62/A8Exy4cwQ=;
 b=acUdXmonHoLuWDZvS0duX8g3PHzg7hLtw+jQvEEEbA6n7Ai9BrPpEWGBsyaA4vZxsb
 ACnjZFzdz45MKIviRcqH4+8YDA/TorKitdV9s5+9S/8HUVfLC+Z41K1bfup5G++KslvW
 cE+a3dhyrLkhp9EXMlMgeAPxZ++Ep/tLZqDRi1xpGfAmvSyzU9EXVypzy29XccDe6dw5
 UwiCuqtyOt8gqATYe7jHvoR1umFmwzliS0i/OrM/yrzE2exQvOCLlEQmAajt7BclYiP7
 T2blIQxT1qL5JFHeRfQX7XvOK3yCtG3XtqbbS91ZsFpHx6NafzebPuKvKl2eQe08aLUc
 AnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757973731; x=1758578531;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTQZvVdeh0u2lyFgzlwQ4yWvPSR7Q3p62/A8Exy4cwQ=;
 b=S+hhBCHZZ2EKR45AtQ1LPDdfDqG4WaswL39/5kFfojOHB5AadQ2jCcXTcU4WpRFoJG
 BIZlWS7VwWjvCDdEn+uroXcYaCNZc2MEG1wEM+TwSfGDQaQGw9h7hdsJvPq0t7yqcI8U
 Qi16jnylFbSM1QCBzRttl/5es6qwMeX2mqRktjrnWm0mT3I1QbwcBBTzaOSrwQ8HL6oS
 x04vF99XjSo5bubK1TGFpOdqUtkvJJtUwVM1eHVEM9n/2mKIM3ig0gsfQlqlinaROqf1
 EFn+MCnPPR6d3vir31sxS+7EEXihHB12rg3DlOJLf/tNpDLDFj1S06DDNAv4m5DS6aIA
 9BWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoKUdqlkBk/yRDOTfHKBNF3MU2p6lxUQ7yW/VsnerLV3c7A31/Wo4sTD2Rcbp1j40vTfScdt/ugPXk@nongnu.org
X-Gm-Message-State: AOJu0YzeOLmfJhCAhSDMGUDJi/HzU90xyrLVUhzw4gK/+xIlJL2C0L+2
 TDjdfVSK5Z/rrtCq/HbzCZYLinNx0Gv2SRzaO9H8Gn8mfbkw/SucgWK+
X-Gm-Gg: ASbGncuwNS80W+2OcszeCxpclXI1cfydMQsGcy0j5CQd3QW8K7U/wJN1Y/VY6HrMjlg
 zQZuM4SSuUrjPrzTRNlYiSXoKS7P45PssHK+R9YM8OrUAsIX2ZteR9VMFU6F0EOTx5ki7ESDPUN
 nwTOM/t6UZjSF4EpjTyMce1H7OtcOb6k3uKZq96ZlXlAxoANPdu75M7InWeLBjOxOhevmTu4jJa
 VFOTb/Bk/FyNLTsFX/i3Oywi3ssLzD9yXaIYh2nr5j+MyzXt08/HyewWQZAytAjxjFMzOZG+bmv
 urKtgQ0UhBAwsSLbl1pfHU/3IPsiMkPiw+QahO+v4G9sr3DGU0hmU1ZoYq4ziyyAXQj9p/gny0+
 uFEmkWx6bpEkYe1uKgF6RZ3tWzcLxle3iyK+Wx2fBDIvWB5GAEBrVg6h8bmIND59/F7slkI8=
X-Google-Smtp-Source: AGHT+IGCmtXDkhpvCc8iGtVCcJnWBCsN7M0KgA8mqiLotWxr92mVfh+28FTer28hajjStQlNUv97+w==
X-Received: by 2002:a17:907:d16:b0:afe:c6a0:d116 with SMTP id
 a640c23a62f3a-b07c3572d31mr1505135366b.18.1757973730940; 
 Mon, 15 Sep 2025 15:02:10 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07d09e5414sm705074966b.18.2025.09.15.15.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 15:02:10 -0700 (PDT)
Message-ID: <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, 	eduardo@habkost.net, lvivier@redhat.com,
 marcandre.lureau@redhat.com, 	marcel.apfelbaum@gmail.com, mst@redhat.com,
 noh4hss@gmail.com, pbonzini@redhat.com, 	philmd@linaro.org,
 qemu-devel@nongnu.org, wangyanan55@huawei.com, 	zhao1.liu@intel.com,
 nsg@linux.ibm.com
Date: Tue, 16 Sep 2025 00:02:08 +0200
In-Reply-To: <20250915163415.149190-1-maxbr@linux.ibm.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2025-09-15 at 18:34 +0200, Maximilian Immanuel Brandtner wrote:
> Update the terminal size upon SIGWINCH delivery.
>=20
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

I don't think this will work, because SIGWINCH is only delivered for
the process' controling terminal. Unfortunately I don't think there is
any way to get size notifications for arbitrary terminal.

