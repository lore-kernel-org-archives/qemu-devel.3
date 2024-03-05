Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D194C54E58
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhToM-0000lI-3L; Tue, 05 Mar 2024 07:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rhToB-0000Yl-TI
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:22:13 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rhToA-0004U3-8R
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:22:11 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c1f582673bso767929b6e.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709641328; x=1710246128; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pcwVtfVReJQ9/rZtS0neC0xot9vnN2geKD2mKJzmNfQ=;
 b=hhv6nwf66kQ56S2XScUKGTDZ7X5yrtL6gcLqqMgrKAFyTJqK2CkOUevasmXkEkk4ht
 caP4IYSljhgAEFszuiy4ejDSUzZhsa7kqGL2lsLvIom6Z8LRPwSaxNxkR5u6ugFsasQr
 XJrQ5Gk+vq162ENcq5EN+vtYWRm202qdNh+LD7iLRkUMpWFTcD3ZuFxcNLK78FUA7gyh
 hsT81NrP+OFF297TD5NxuV4MiGi1FheZV5ODKoub9lplqussLiMvcN66BFNk9p7Gu2cE
 biYTD/Ab60ovPTYdzTNVrtvjbYU7Cyo8C/IAGb/9HPGJ8+UxHhPNo/+xJHl090mWJKNm
 GCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641328; x=1710246128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pcwVtfVReJQ9/rZtS0neC0xot9vnN2geKD2mKJzmNfQ=;
 b=g1y5y7aC/0DFIYiQOjYOtlJNmCRcEzP5FFd9b4gM1ZNdtqWC+Oim48Y0wueL9wI4iJ
 ykpa+6QA/5l3KNZuHzd0ce5Qtz8xnfJT7lRiorEmbTTboZixR3V5gXLnneXv/W3BeYJl
 c7A0I3jb9g4YLzQQZhR3mtKcF1in1iUOG9d5fhKGi7ujDL4L7iGfQSkujfo5So11yT6P
 +4vc/gnuwZW/IhhwbDSa3MXUpIHCDr1jZ8x6anA9LbBscP3gfJ5hylTxGxS1fQzxQddY
 iW3WJsOhPpCwqjo7CSOFInuJnkNegVgxftsaGs8HzsDudFFk17RdSj20WDBHmzUIsYc+
 Vndg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXdzK/gN5vD8XYO7/Fed5g+yjrASvcx4Pl/DgkqTE8c8/AV5gUQhO7zy+RCTk+0TXbuLOc9vrqCIhkKPAVzZkUVXExz5Q=
X-Gm-Message-State: AOJu0YzyPW2ZqaG4UUSdiiobnuk+DIWF24uy78k/vR5NHT4Heu76eTdY
 IiaYCKbzbfZW8abX4oOqA+fkbK3ZljELlMVvRZIATIoGkEXBkuqcLZ8RU9YhhHXWia043bOwQ2v
 lB6Dsdvd6mIR/9HrKUkz48bNjv6Y=
X-Google-Smtp-Source: AGHT+IE52AQAlqACfuyvZf5611/95EB0HNPP8MiFVJBaTgbe/ZTIc/i3EE7nfXLa3FM9efiex16TLDtXlxt8877rVmA=
X-Received: by 2002:a05:6870:538e:b0:220:f3e8:c748 with SMTP id
 h14-20020a056870538e00b00220f3e8c748mr1594683oan.37.1709641328175; Tue, 05
 Mar 2024 04:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20240304185149.1475336-1-mjt@tls.msk.ru>
 <CAFEAcA92XprxAegJMj=iTsJNmmWY4RG89M48C9EOARgGHJxcyA@mail.gmail.com>
In-Reply-To: <CAFEAcA92XprxAegJMj=iTsJNmmWY4RG89M48C9EOARgGHJxcyA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 Mar 2024 07:21:55 -0500
Message-ID: <CAJSP0QWk3hH0Q3RZgk0qwrHcjKj0MN5Tq0b6sWHsN3zUtvgOcw@mail.gmail.com>
Subject: Re: [PATCH] make-release: switch to .xz format by default
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 Michael Roth <Michael.Roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 5 Mar 2024 at 04:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 4 Mar 2024 at 18:52, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > For a long time, we provide two compression formats in the
> > download area, .bz2 and .xz.  There's absolutely no reason
> > to provide two in parallel, .xz compresses better, and all
> > the links we use points to .xz.  Downstream distributions
> > mostly use .xz too.
>
> Seems reasonable. Out of curiosity, do we have the
> download stats on how many .xz vs .bz2 downloads we get?
> Stefan or Paolo, do you have the webserver info?
> (Probably not worth bothering if it's a big pain to
> get the data.)

I don't have access to the CDN stats. Maybe Paolo does.

Stefan

