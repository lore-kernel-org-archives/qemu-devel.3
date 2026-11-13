Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC5606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J7NM3A5U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRulP-00055w-I0; Fri, 13 Nov 2026 12:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRulN-0004xC-0y
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:08:33 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRulK-0003PK-5L
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:08:32 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67bf3c6654fso1351488d50.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 09:08:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794589708; cv=none;
 d=google.com; s=arc-20260327;
 b=ct7f5XdzvFC5x0bhLlT5WPZXSiEbQ/tn81gMw9XoN01gKtFV+Ugzo8SOaIbxUTgTdD
 wwzf/0V0RLlqrZGv42w3Wf2jm64z42HlAtCE/IryVI0KbILE4iFd0F6UWE1wmkCxPEUK
 qOTsLyUb0SmAw6gut8vs0B4+lO8Rsly9/hnESzOdAPEbvedUgdU+iBWJ9OrPmlpVUI3I
 B2m+YRckBZOw26AlWP2vMKQwqQgh0cDIfeaPL4efl33XU40COJl1bXC5ukaNJs49kvyv
 G6QvkVjynnuCVKq9wz4bl9yfKSZtDRvQTXV5dmApY/FqoT6iCoFtsy5sZlvtvpcwV6xs
 Uk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=k2OIs3+p2FlZo0mCaxEqoqUp7K66gdq+zedHy7JrRPM=;
 fh=Kif6ZkX9zWLatEoKkHHBkqtz0GTIi5lrj/U4WuoZBzA=;
 b=FYEma2FS8B/+2CcWmV98n1PT9aBJvP8G1OLEb6ra2OzKqOLrmf4Dz4Y22ZMFBbomhO
 8yjYzaHUad6E9N2blJXTeTDB4Pg+/5GO7twgJaFNj/RdEVX/T5Dh4fkd+a+0oirTERa5
 8MhgAA5xlgIkX4G+wwGJtiofUwKkoU3GRE60WCTRoa5qPIK08OFk4NQW5VBRVxTyrT9Y
 JPLTXO1N9RBouKPW3smCJ2G+iZ/+t7/rVtmXMI5IhIffImOeAIEQ7wY5EfSEke0wV0TM
 ObQ5gvOSKmE6hiOBcKUpijybrS/mMnR7yhTSTyHxfo8uie/xBUpyWcyC8y73o3Ysp9C5
 s0aQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794589708; x=1795194508; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k2OIs3+p2FlZo0mCaxEqoqUp7K66gdq+zedHy7JrRPM=;
 b=J7NM3A5UT/gCUMgXFLBRQYzFIXH06R/JuszuezacLKn1/o5wqgQGuFSgqsKnSQ4fKv
 cd8XRuEH6OTXf+3ogCr1bqDhfkN++/QW8A8FgKF7hcMlmP2v3hSp3o80/KkpsuDUmwFu
 PBSOX7tZv51E9zwGsaWEZee1x6L0Xz0RURtFuzXqRgnNxOJbPhVY1WY+qfteQfxaWVcj
 ol04X2jlNk1YHNUqE0x7pa+LJEOxryQl8lrXEqgWpxERKas+Bqrqbt2qNXva+yxjJ+lq
 xDIJeAgEPLKGeQI4XMO01jWQMBSUFCzfzOX3Ni09Cceb5yTFM7NLr2ebdBACzVoYsujS
 xlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589708; x=1795194508;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k2OIs3+p2FlZo0mCaxEqoqUp7K66gdq+zedHy7JrRPM=;
 b=DH+9Sgio+LEtKHn5eKgddq2PX/Hx6kcLdR8h3DjftWehCfI1T29kijW8zpjY3LgSSt
 3sf/NVGXNwUJVbU87J/XmyjSG4zibj/wr56WAOYKsTWJOf8pfQdVSyc5PkR6KuCEd4U4
 Qm/X2RnHXYj0tYp+sEKB2B67esNwGYtIYnrGIVslPDbtdMCMPTuVIJpiMMGr6+BIhRRS
 uRh0hJeAZAYgMb2FKSobO8tapm6HnV4LnaBxmOUbN68+eDrOSbjwjy4ZinK2nTJnqXZX
 9xBWuuh2P2ry8Aps23AHWNZVpL5LlsRdVI8XWmR4/WBJcU0Cj9Nk2bpMaOZbK8XO22wH
 kUAg==
X-Gm-Message-State: APuU4Z/n0CWGETqyewBkfutheR4nrio60/EV8umhNGZ/pGHg14+PpoFV
 GBFL1uyhBWJaIcRBaL1K3mtJgaoupcWwfUwuuPZrOQ8Puxq2Eu0FTebGoYJaC+I8Q7aGR/nstI8
 +OdPz5sqLGiOL4FNLL3mwsFzcD9JUkRdWcpPWrRMywlXjir78FABZm6AwoQ==
X-Gm-Gg: AYBFou3gM6Onz1GMik7k9DnHZRyrrB9PdUxMric6ZReJKGNCOnJKFxMMb+3WOYo0oqm
 fOVs9lyBdrijR//rkhZXqCmqWh9VY23g6RRkL7waqQ3RBhhD97btEYX+ph1vyrsWfMtbCcSWuV1
 lNpLPD2mAzGomUCvVHHY1gREpxuYdFASRlVg7iNBf01z5Rq1v7+PztN+d3c7iaIYaowaeJQ6EdS
 pI15Bkrod3kPnRuS2vPiZi1lQSkzc4T5dMbUVjGEyDjrdfIf8+YbIlUKgFqHr4Otkwea5JX7A0j
 nt8MSmcIa/x2wuMqXA/6/Czbb4ng4RsIfvGiES739HYlJgaEM7vyK3LvXBfnv1AoJpklkyfcyJ/
 UDo2T9vDwgk85zkqYqNvSKUmsrY5OX777HJiWSTnyu5MVNOjlZX7ddcNleviC0yv26wX51SV4/0
 c4yO4wNCX4wjR0JVf316QJ
X-Received: by 2002:a05:690e:4847:b0:677:d251:ccc6 with SMTP id
 956f58d0204a3-67d89667efdmr1165127d50.71.1794589708248; Fri, 13 Nov 2026
 09:08:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 17:08:16 +0000
X-Gm-Features: AclHuK91zZPBlsnoNz9wKWYmc-Lo83M11WvP_VRucf94oklhPx3SAh65xMpyfBc
Message-ID: <CAFEAcA9Ob8CsaufaAZ6jUhrKkxSfCkcig3ciG5LK_WCNCi14NA@mail.gmail.com>
Subject: Who should be allowed to unrealize a device, and what can you still
 do with it afterwards?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We give QOM objects a reference count. This means that if you are
going to try to use one, you can take a ref to it, and then you're
guaranteed that it won't disappear while you're working with it.

For QDEV devices, we add the "realize" and "unrealize" steps to
the lifecycle. There is no "reference count for having a realized
device". So what do we intend here?

(1) We could say that if you have a reference to the device then you
can assume it's not going to be unrealized under your feet, and have
very careful rules about who can unrealize a device and when.

(2) We could say that if you have a reference to the device then it
might be unrealized, but it won't be deinitialized, and you can assume
that all the API calls you might make on it will in some sense still
work, and at any rate at least won't try to access memory that's been
freed or crash.

In fact we don't say either of those. What we have instead is:
(a) Some devices will free memory in unrealize, so aren't safe to
make calls on after unrealize
(b) Some code will call qdev_unrealize() on a device even if it has
a ton of references on it and is likely still in use by unrelated code.

The specific example here is the problem described in
https://gitlab.com/qemu-project/qemu/-/work_items/4854
where if something writes to the PCI hot-unplug memory mapped register
then the PCIe code will immediately call pcie_cap_slot_unplug_cb(),
which calls qdev_unrealize on the PCI device. For PCI devices,
pci_config_free() gets called in the PCI base class unrealize, which
means that all the PCI functions which look at e.g. pci_dev->config
are now instantly not valid to call (the one that gets called in this
example is pci_set_irq()). So if you can get a PCI device to do
DMA to its own hot-unplug register then it's probably going to fall
over.

Should the PCIe hot-unplug code be more cautious about when it actually
unrealizes the device being hot-unplugged? Or should the PCI base class
code be being careful to make sure that all its functions continue to
work right up until the device is deinited? (Or both, or something else?)

My fix for #4854, now on-list at:
https://lore.kernel.org/qemu-devel/20261113165015.1150646-1-peter.maydell@linaro.org/
is "make sure this particular device can't do DMA to non-memory", but
I feel like this is pointing to an entire class of bugs where the
underlying problem is "hot-unplug can make things vanish under your
feet". We already put a bandaid on the hcd-xhci USB controller in
commit 89e653b773 and the lsi53c895a in commit 4862d2c95104d, and no
doubt there are more...

thanks
-- PMM

