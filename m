Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352CFCA100C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 20:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk7xu-0004Rc-99; Fri, 30 Aug 2024 16:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1sk7xq-0004PB-4Z; Fri, 30 Aug 2024 16:11:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1sk7xm-0007B4-Ig; Fri, 30 Aug 2024 16:11:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2021a99af5eso19311205ad.1; 
 Fri, 30 Aug 2024 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725048676; x=1725653476; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IHM+KYZHR2hQQb7wYxqG6dXazei1ToaezlSlDokFFvY=;
 b=TdyjPLY6b07gaOgfQW6cYA+Gef77eFnVUHdwp9dOQQkQr9ncXxQRyoEmbAQjkifMrj
 EurPqp1r3/UQeORCXJn61D+FnIAANZL8k3k5irQdzKjXKzcKl95aX5NVjHmq1ecPEBJV
 VJxeViT/2WAgfM5+VubetCxKIE7de38J7bDQyjDmTaONlyhQ22jGzmtuDsjOG0CqH1qk
 Ygc1EuKPiLuUkxYChq4HZHw9spkZHBka4LKx1o/4WcvWZrZSUDXSWkeoyzKqBqNQbTNq
 6VRQ94uu54pgC10nGqffrNBt4weBLmXaQgypZvsGyTLJQT5FcnrHONTZ1MWRNRVBZ6Mq
 uKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725048676; x=1725653476;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IHM+KYZHR2hQQb7wYxqG6dXazei1ToaezlSlDokFFvY=;
 b=k/XfxuJl6Xh65yyr/wjD6jNuBCJ4RQMFgSmwRx4LmW0XIMLSPsvXeTEsZzCqh22HwH
 6WU+/+e3zDFMpmlVp853haUEjfRr/YBFF9YiwfElvMRi0GFFCCcdx6I4dpA6EzgZTk8a
 eWBRgmIGtfH/kYFepCzO31X5ijPLr4pbW0CvbtwhW9XWbPH48U0yH7mJmSd9N0pMWmrM
 gW85acA4Uu/Rr/TKGjIxJSFFPeneo6Dbt5QIXV+zOlM1I4gA971mlfkJqo3YejZ39X/k
 8NnPRJKPNG9NNs2g8CNeJ41BIdDBDv03XKcQxzeXmFOHLNkP/dfTuNTN3OKkLymWdZRL
 GMNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk3kaJ49kcZAnq94yawxR1yyS8RaC5JfZFE9DjU3/PzECWue7CIL59anOkOi7lNj9HhfAeHPOtCqAo@nongnu.org
X-Gm-Message-State: AOJu0YzubtkiacN1nCTAXTSWXPYxfqHzIoxEYxeH1SRSNU+twMvNXHLt
 5kmZXJowEShU+DB1F/mtHeqH7+zA3l4a+xt1mTbz+xf/LOHsKgUI
X-Google-Smtp-Source: AGHT+IGhcbKUh9SFBdIDSMBWWPIBCGeHCjC7y2HaGI16KNP/5qfRB/i57Ejhxnj/Cd8KB7eIkD5KTw==
X-Received: by 2002:a17:902:ce0c:b0:1ff:4d2a:fe43 with SMTP id
 d9443c01a7336-2050c47ee4fmr72759275ad.61.1725048676254; 
 Fri, 30 Aug 2024 13:11:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-205152d02b4sm30508585ad.87.2024.08.30.13.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 13:11:15 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:11:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] aspeed: Deprecate the tacoma-bmc machine
Message-ID: <09457da7-e692-4d9f-92b8-361f14b7a1c2@roeck-us.net>
References: <20240625070830.492251-1-clg@redhat.com>
 <4e04f930-e7af-4084-99a8-2a3139e2bf43@roeck-us.net>
 <5fb7342b-fa67-4cb2-b6fd-2241b7b76d03@redhat.com>
 <f70cb39f-3567-4322-b1c4-1bc5991d91fa@roeck-us.net>
 <8d1fd867-647b-4827-a2b2-a239618a7743@redhat.com>
 <014b83a8-d733-442b-ba33-a24c35e46f3f@roeck-us.net>
 <bdb443f9-376e-4d4e-8c06-9ba0c5482c5e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdb443f9-376e-4d4e-8c06-9ba0c5482c5e@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Aug 30, 2024 at 10:09:25AM +0200, Cédric Le Goater wrote:
> Hello,
> 
> 
> > > > I solved the problem by adding support for IBM Bonnell (which instantiates
> > > > the TPM chip through its devicetree file, similar to tacoma-bmc) to my local
> > > > copy of qemu.
> > > 
> > > Hmm, did you copy the rainier-bmc machine definition ?
> > > 
> > For aspeed_machine_bonnell_class_init(), pretty much yes, since I don't know
> > the actual hardware. For I2C initialization I used the devicetree file.
> > You can find the patch in the master-local or v9.1.0-local branches
> > of my qemu clone at https://github.com/groeck/qemu if you are interested.
> 
> Oh nice ! Let's merge the IBM Bonnell machine. We can ask IBM to help fixing
> the definitions (strapping). Enabling the PCA9554 is good to have too.
> 

Sure, let me do that.

> Why are you keeping the tmp105 changes ? LGTM. Same for the new tmp models,
> they could be upstreamed.
> 
Ok, I'll work on that.

Thanks,
Guenter

