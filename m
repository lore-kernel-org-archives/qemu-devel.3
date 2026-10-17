Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0281ECCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIAuF-0003Sh-Vs; Sat, 17 Oct 2026 16:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xI9qX-0000AT-Rc
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 15:13:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xI9qU-0005Zq-T4
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 15:13:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso5834665e9.2
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792264409; x=1792869209; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o3AL/EqmkSj0Ht7RBWdIVuBsJTZwUu4cHBWJaC/CRl0=;
 b=MWoHIyGtREuaYGV37r1tg6lY8e/DO7YDxwPWzu64zY20eoMpM5Cav6xeSfk4ESRp5L
 RO/o4aGarZdHpQlAdAotz0rOyt/3CjSmX2u0/fahT+VDnJ0hTymiNfbqK8Voxor6uvZU
 M3rbm9l2y8qdWmRX90P+At3/qzess+ZHfStkwuXuXkHckTsnn9/LFFMnaSPU2kAkHFAB
 n96hNlpyWSujD6pl7rikzXusgzN9M2Vsb9ZWfb2FPuQbjmuCQyo5RYf85ZcFyq80w8j2
 kkY4MbV0ZeEjEpP1axQ1c+HBw/sWm+6D7dooKdkYjD7BTejWJRgLEU1+31K30Ej4nt31
 0UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792264409; x=1792869209;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o3AL/EqmkSj0Ht7RBWdIVuBsJTZwUu4cHBWJaC/CRl0=;
 b=C2F2cFA1wYTXsfhW03Vd+qhihP9/nYCLBPCI+dbQ33wXliknaeLusT+AsH4vrm8x4F
 UA73jt9WX33U2mYtFjnNneM6iFady3c4j/PvhpfRFtdr9vUiXfwq/TRXsoCu9vo6keHY
 P/y0SGnnYPypdmlJuLpjo2cVvr+bqiftYM7Em34pNE0hHMYfOMKrWZ4cVLEf02UENBl3
 CbH11+nKV0BaYbggxPxiyliefOdFVEPg+hQcT5gwkqUZUa6P/lsleyve4TG3F7z903bb
 hrCUuEA/utFN4uE9NnIWjAbB1gyc+v+qs6YuaiefVsJxGbdK67UcYCAci8CJqoCigKy8
 Lc+Q==
X-Gm-Message-State: AFq9FYImLvizcO5tAYRhcc/jIF2zVLqe3aAmuSon5P7Pa7FbUFldoYNn
 ptjiwHzhW2iQQDI/UR3oraTKtbej0fy2PVyVNkg+ZSvbVhVTHL4hfsBE
X-Gm-Gg: AYBFou1M9GJ2EZgHP+23wFda7VNPcWTvwX4l/bL5v9DB82Mo0nuwvdeszzokQ3mVUvq
 29ngEO9XqlvMYSw7R+efpTS6061jC3dnC5Os4XzwpTV5Q/YPP1iWCyVujlypOe8AKzN0Ry+LsiX
 LR0dc4UI9DfrCvl7gXuV1eqov0i0isdDe6/nXgVCIwcnxOuSa9CGir0yFeGzLmTVjuqtjWG/RGg
 aL0ki7UKl/laxEm7AqhBFfWgiMGy1gK5IExwonZhxz66jmtjeSdgZVVTL3pzzjnVI99Zr6bpmk/
 hXgP2578+ZP2/HKqjS/AqejKI47CZ7c2aCHlLYM3Alg+oLq9ca79w2ryvjYmsqQWBtwbUUJasJA
 IE0LWOtYHdFC57Csk71YHdY8zF2D3S7niBzm+P8sSp35Qq1VP0bxcr6gNADzRaGPayAx/H2JTsq
 zAXGlPFq+qRzjMHKNN4qcMQOlKxhPcxNHEaUwY6iRpm41drPMGgelPC48GUo+DLXI=
X-Received: by 2002:a05:600c:1f83:b0:4a0:27eb:49b with SMTP id
 5b1f17b1804b1-4a1d761b900mr65324415e9.30.1792264408211; 
 Sat, 17 Oct 2026 12:13:28 -0700 (PDT)
Received: from localhost ([31.7.57.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d0e2bb8dsm121916705e9.2.2026.10.17.12.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:13:27 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:13:26 +0300
From: Alexander Epaneshnikov <aarnaarn2@gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille, and following the
 input-linux grab
Message-ID: <atPIRr46KvMoiCti@alex-pc>
References: <atNoDNz0dQucxzFN@alex-pc>
 <atNo9sk_7jCAi98u@end>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atNo9sk_7jCAi98u@end>
User-Agent: NeoMutt/20260616-dirty
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=aarnaarn2@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 17 Oct 2026 16:21:26 -0400
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

On Sat, Oct 17, 2026 at 02:24:22PM +0200, Samuel Thibault wrote:
> Hello,
>
> Please always keep some mailing list in Cc, so that I am not the only
> recipient of the mail. Writing to me only means risking falling in
> the middle of my vacations and thus not getting an answer for weeks,
> or that I just don't have the time to answer and thus you would at
> best get a terse answer, or worse, no answer at all... Conversely,
> keeping the list in Cc means avoiding all these issues completely,
> you'll involve all the community to help you, make the answers you
> get available to everyone, and even archived for web crawlers to find
> them whenever somebody has the same issue.

Sorry about that. I'm adding qemu-devel and the BRLTTY list now, and
quoting my original message in full below for the lists. If anyone else
on the lists is interested in picking this up, that would be welcome
too.

> Samuel
>
> Alexander Epaneshnikov, le sam. 17 oct. 2026 15:23:14 +0300, a ecrit:
> > Hi Samuel,
> >
> > I use a HumanWare Brailliant BI 40X with BRLTTY and Orca on the host, and a Windows guest under libvirt with NVDA. The keyboard and mouse go to the guest through input-linux with grab_all, toggled with left+right Ctrl. I wanted the braille display to follow that grab: NVDA's output while the guest has input, Orca's when it's back on the host. I have a local prototype working, and I'd like to ask whether you'd consider supporting this upstream.
> >
> > 1. NVDA can't detect the emulated display.
> >
> > NVDA's Baum driver treats 0403:FE72 as a serial device. For serial ports it detects the display by sending PROTOCOL_ONOFF (0x15) to turn the protocol off and then on, then waits for the cell count (0x01) and the device identity (0x84). chardev/baum.c reads the 0x15 request but never replies, so NVDA reports "No Baum display found", even with an FTDI COM-port driver that covers FE72. Replying to "protocol on" with the identity and the cell count fixes it. As far as I can tell, that's what real displays do.
> >
> > 2. Sharing the display between the host and the guest.
> >
> > My prototype adds a small grab notifier in ui/input.c. input-linux fires it when the grab toggles. baum then changes its BrlAPI client priority (BRLAPI_PARAM_CLIENT_PRIORITY, local): 80 while the guest holds the grab, which is above Orca's 50 and the 70 it uses in flat review, and 0 (disabled) when the grab is released. BRLTTY then switches between the two clients on the same tty without reconnecting, and each side's last content comes back straight away. Under libvirt, QEMU has no controlling tty, so I also set CONTROLVT in the environment.
> >
> > Questions:
> >
> > - Is client priority the right BrlAPI mechanism for this, or would you rather do it another way?
> > - Should it be opt-in, for example a chardev option?
> > - Should other grab sources (SDL, GTK) report to the same notifier, or should it stay limited to input-linux?
> >
> > One caveat: I built my local prototype with an AI assistant (Claude). Because of QEMU's code-provenance policy, I can't submit it, and I'm deliberately not sending you the code, so nothing you write is derived from it. I'm not able to write these patches myself without that kind of help.
> >
> > Would you be willing to write them? The first one, answering "protocol on", is a plain bug fix and should be small. The second is a feature request, so please do it whatever way you think is right; my version above is only to show what I'm after. I'm happy to test anything you send, and to provide NVDA and BRLTTY logs with my setup (Brailliant BI 40X, BRLTTY hw driver, Orca on GNOME Wayland, Windows guest with NVDA, libvirt, input-linux with grab_all).
> >
> > --
> > Sincerely, Alexander
> >
>
> --
> Samuel
> «Tiens, quand j'aurai un peu de temps et une partition libre, je crois
>  que je vais essayer de remplacer mes scripts de démarrage par des
>  programmes Windows lancés via Wine et binfmt_misc :-)»
> -+- AGV in Guide du linuxien pervers - "J'sais pas quoi faire... (air connu)"

--
Sincerely, Alexander

