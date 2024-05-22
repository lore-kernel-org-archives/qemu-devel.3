Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EA1C25B74
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 01:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9amG-0006lE-J1; Tue, 21 May 2024 21:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9amF-0006kx-EM; Tue, 21 May 2024 21:28:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9amD-0005Ba-Ms; Tue, 21 May 2024 21:28:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso6333075ad.0; 
 Tue, 21 May 2024 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716341299; x=1716946099; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8+45UbJqhnL0QMSfsyZha24gsr//tDC6rBG6qGE3m4=;
 b=AA9cxbcvFpwiULM+3DeANR9BCk1PR4oz99aKmazHYXFtMSGpmDdMTZDJYC6arRZOPm
 bb11Ai5nVjBYOnL+zsi8dfTz2vbeTIYlTYMn+Q+podt6eszwIoNHLnEB8rUdt1suIwzD
 VeULFx1i0f6yOjj56dvNX2srBScM1TDy/SOyd6slpjAGmxc+mV6lqWDoefKh/Ijlc5bR
 Iz/aS0rVh8rgeLsV07TgJVNguGc8DuLRk0q6G0OmeXT7Zmcq4SDVJ7TSe6njEY8velsy
 tWM+3dD+dFrc6Gw6sEv/WzvcRDV9jj20glxpGf+fRQQxIDSwEQ9Bw/cF24G7kKs2ti28
 tHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716341299; x=1716946099;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z8+45UbJqhnL0QMSfsyZha24gsr//tDC6rBG6qGE3m4=;
 b=dki9UDWBhTkesDKummXv82TbaULgfEmNWFwZwplicOOPPMPMrqVgwuuTkaflZDebMP
 D7SVauavwKsf7LeNjoad3KPMrrZG0t3ufoJ8dDACGUl42irPjgh9Yy0qHobimNWQb+uC
 wq2KU299ChH49opg8+iVVbKdTV4kksEZx4Gape1Y0887FZlRIzBSfcftK4/plR8W4FjG
 nDKvg8cNo9jpI2ikQvF/jzxiK/HP3+1jRV+GPbRaUFndXKxlC5l+8pjwhvB6aMCa1FE1
 qTZyJkzIKQfMdKB4NE+y4jtsqgm0pPxFq5G1kgnvT7aG508c7Jne49HvsF/DQRptciDU
 aNBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4eqYylEyLIRE+lUT9wKofA/GdlfO6Xp88KpJ1/6nUMRmAA4nOdOUxDlo5pJ8GUaB9X63q+SwGllWSre/ahkOrB5LbYSbH8fZgXMPIPed7MdnX8PiYwmppXH8=
X-Gm-Message-State: AOJu0YxHK6TYx1N2RWiNe3aGOp81WN4joD6QbaGusRZY/p619hl/Syty
 dcb69W4N22uVNa6G4hXeJpOlCh9jVzf/eG/NmubYGXKsqlKtpHG/
X-Google-Smtp-Source: AGHT+IHqWtHKPsb4gI9rhghHOXq0HhPOjld4CQEuRFbpYgFdGCerdkVihCPVCJkIcnfG4fkygJcYJw==
X-Received: by 2002:a17:902:70cb:b0:1e9:470:87e6 with SMTP id
 d9443c01a7336-1f31c990022mr5923175ad.23.1716341298843; 
 Tue, 21 May 2024 18:28:18 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f30dec58d7sm20426775ad.22.2024.05.21.18.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 18:28:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 11:28:02 +1000
Message-Id: <D1FS7GB6BURV.2A48UEVLGWWYA@gmail.com>
Cc: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "Jonathan Cameron"
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net"
 <salil.mehta@opnsrc.net>, "zhukeqian" <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)"
 <wangyanan55@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "Linuxarm" <linuxarm@huawei.com>, "Shaoqin Huang" <shahuang@redhat.com>
Subject: Re: [PATCH V9 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240519210620.228342-1-salil.mehta@huawei.com>
 <20240519210620.228342-7-salil.mehta@huawei.com>
 <D1EBOZTRN8SZ.Q9F4CFDZ8VYW@gmail.com>
 <46d1577dc27a4012bb90d9871d03fabe@huawei.com>
In-Reply-To: <46d1577dc27a4012bb90d9871d03fabe@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon May 20, 2024 at 8:55 PM AEST, Salil Mehta wrote:
> >  From: Nicholas Piggin <npiggin@gmail.com>
> >  Sent: Monday, May 20, 2024 9:19 AM
> > =20
> >  On Mon May 20, 2024 at 7:06 AM AEST, Salil Mehta wrote:
> >  > Virtual CPU Hot-unplug leads to unrealization of a CPU object. This
> >  > also involves destruction of the CPU AddressSpace. Add common functi=
on
> >  > to help destroy the CPU AddressSpace.
> > =20
> >  Patches 6,7 seem okay to me. I would like to see a series where they g=
et
> >  used. Would it be possible to include at least a TCG user in your seri=
es? That
> >  would make it easier to review and test.
>
>
> If you wish to play then you can use below repository which is V8 version=
 of
> architecture agnostic patch-set plus architecture dependent patch-set
> stacked up together. This effectively RFC V2 rearranged with clear separa=
tion
> of arch agnostic and specific parts and some review comments incorporated=
.
>
> https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3-rc1/
>
>
> It has TCG but it has some issues and hence we have disabled it for now. =
We are
> working to fix it.

Thanks for the links, I will take a look.

Thanks,
Nick

