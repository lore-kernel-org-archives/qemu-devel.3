Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A26CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 08:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjPP-0002rp-7D; Mon, 07 Oct 2024 04:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1sxjPN-0002rd-I5
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:48:01 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1sxjPL-0007V8-83
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:48:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99415adecaso228450266b.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1728290874; x=1728895674; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzUEqLGgBpjhYFGQZ9H8BLVfnvq+rcdLqmkgHafR+4k=;
 b=Zy5072a9jnFzKkrX4cLeWscBiDYokSV7tj2Gt9RDZSMePCWq6hMV3vvccTNaV/Sx43
 aTyvfWnqS6uyXKy5cPupZ3edD1RcMf2RfGcoRwer1JhnCissQ02pTEyiuhujTuAWaFeP
 zpLcJjlKbIXL3n6PzhUjOwKvipv5OJmlRWMEp0Nt2o1Phf706lABdfcTBuxHlS1wcK8m
 J038aeeoaRoMEWICeQQ870a7GSzAj2ONmf6HPGz0kIwaIIct/dxH39mczSU8gr2Rq3o6
 Ybln+UgcUqmReOwLGnWd6MvwZxLtQIWPunuiR35sTGmyIgVYiYmBT7pHEl3Ccb49RW02
 yJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728290874; x=1728895674;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzUEqLGgBpjhYFGQZ9H8BLVfnvq+rcdLqmkgHafR+4k=;
 b=KyMTQfjF9sK35M11d6WpACfbplGbbOx3Sc+Ph7KEeMrcjacrIxVLqQtBMC8joQHZwN
 1vs2ytt2Q0tye4TfpoxY8pj6lsiTLfAkxp9hSLpZJ6BqXSbtcoq92jZ9ofmLkVCA4b7w
 ojNI1Hbh4yemOcLsvL/Di90DtVzYivgrapwilNfDE8VUwZok0J8fsy9uKPmpQxoFmNTd
 OhFIjDeyV+XIZY3Eux0XnWvWib7G0wAZPfjlu+bGMVfkDYiARRXxexdqW8hvqPymMK6i
 rTGoZ529MME2IP6lOgK7TdqKRFV7xOfXkXRy3UVHUpa3bOULQx6lvsqpwng6for6ASiA
 yQmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuRXvz0VGNPdPJuAtjm5bET0uYSre+r8krlk2UznWo0tgrHu9CNUs3/fu8GumccfRMtAEht9PsbD1y@nongnu.org
X-Gm-Message-State: AOJu0YwiKd8FWBbi8Uva6Hr2XwffeYgQ9C4wOe80pzLbFYfvEuJRtZuZ
 Fnyz1Y3xeG8TF3tHDyANud1VN0ypL81kb5ZxrRb0IjgyIJET/AYw3Zp32Zp0LdpOkGAVyNbeALX
 yAhUApM/MK1zS7H53BVqcSBR7zlVpI6XWonGkvw==
X-Google-Smtp-Source: AGHT+IERaQnCPkAK/FIfZ14/veEXDzO8cK7gQpVnqkVORGG78Cam24um86yXZInGL4nQR0ZJmzJ6/VchHf492NRNDl0=
X-Received: by 2002:a17:907:f144:b0:a99:4045:c88a with SMTP id
 a640c23a62f3a-a994045caf4mr627124266b.0.1728290873844; Mon, 07 Oct 2024
 01:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n> <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
 <Zv8P8uQmSowF8sGl@x1n> <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
In-Reply-To: <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 7 Oct 2024 10:47:43 +0200
Message-ID: <CAHEcVy7_WveokcN+3J2Qqxg8oJ1BT8sNoU2qUHeU8oZWwVyS6g@mail.gmail.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Sean Hefty <shefty@nvidia.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>, 
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, 
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 Xiexiangyou <xiexiangyou@huawei.com>, 
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>, 
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62c;
 envelope-from=yu.zhang@ionos.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Sure, as we talked at the KVM Forum, a possible approach is to set up
two VMs on a physical host, configure the SoftRoCE, and run the
migration test in two nested VMs to ensure that the migration data
traffic goes through the emulated RDMA hardware. I will continue with
this and let you know.


On Fri, Oct 4, 2024 at 4:06=E2=80=AFPM Michael Galaxy <mgalaxy@akamai.com> =
wrote:
>
>
> On 10/3/24 16:43, Peter Xu wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> >
> > On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
> >> What about the testing solution that I mentioned?
> >>
> >> Does that satisfy your concerns? Or is there still a gap here that nee=
ds to
> >> be met?
> > I think such testing framework would be helpful, especially if we can k=
ick
> > it off in CI when preparing pull requests, then we can make sure nothin=
g
> > will break RDMA easily.
> >
> > Meanwhile, we still need people committed to this and actively maintain=
 it,
> > who knows the rdma code well.
> >
> > Thanks,
> >
>
> OK, so comments from Yu Zhang and Gonglei? Can we work up a CI test
> along these lines that would ensure that future RDMA breakages are
> detected more easily?
>
> What do you think?
>
> - Michael
>

