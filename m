Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BACC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjdtP-00066B-Qy; Mon, 11 Mar 2024 07:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rjdtA-0005xw-1Z
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rjdt5-0007c7-3u
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710156728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38QKk918tg8HsWKrtzXQ/xwk32hwz9Kpx4HhCSeUxbs=;
 b=F8+8msRb8kNLleYnYucrozzDoJzEIt0RERzh7GEvijDQV62NdXUEMwBuyp6W+yXb7B8XPP
 DsJYDn+9T/obYptznSixEyPjzHBRS7OKuC3Z8CyCIPlwiNZM5Lc2quupLbID54HpFyfz4r
 VAr3fUCKyhuNRJxFav/xvdbqP82yWWA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-p783ymx1MCa4aGxr0R7T0g-1; Mon, 11 Mar 2024 07:32:07 -0400
X-MC-Unique: p783ymx1MCa4aGxr0R7T0g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51345bb1d1fso3264409e87.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710156725; x=1710761525;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=38QKk918tg8HsWKrtzXQ/xwk32hwz9Kpx4HhCSeUxbs=;
 b=YIxoksReAmLSWpWMMkyXrG9ZkFKuB/PCG4cqn+hX8tkZg1z0VCzvNa33CSWpDQzCmq
 xVb/5g9CZw0D5Dthe/hdgWc2GRcSyNV/taBhLXua52xazrDNznjA0FW37wDoxBcMn0lV
 c4IZqFyqc2m88iK8w8QSPGmevqUemoN0FZBCyQQHtHr3mxrAjBFgJrQT5T+F5Wd5UWmC
 RhRrVjYLb/qQ2CQB1rzI+3TNPT06anISLCKIImnd2zbg97FIyqkxfghLaoNTggB9YWSp
 LFtoE/rhyBz0v+Epbpcd8BdEzqww18aa8tyXABGuAe03WZo4MPvNoXlg+KPCdXULGPW+
 9iKA==
X-Gm-Message-State: AOJu0YxzjtJFdO+qcXTX2sxQaHHIYCgIcpQ8nwU0srmYubo4jno2Uzud
 gK9ErNcsrXNLFq7euu4JKdO1IlgiRUtlkndDBkdm5CziKeImsL+dffbKyYzmcbmVM7EOATrro/G
 s0TwXJBJroUBg9+XfkRAp2wYsYYX2AfOhGeif7nGbZFhQkaFsl5bn
X-Received: by 2002:a19:4311:0:b0:513:1cb0:174 with SMTP id
 q17-20020a194311000000b005131cb00174mr125458lfa.19.1710156725672; 
 Mon, 11 Mar 2024 04:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB2AmT0klWZMWetgoh11vRnTuH9ihuzzWQqQMvfX+TKwAStyS/yJWjC1U7R1BKawYSTBR5QA==
X-Received: by 2002:a19:4311:0:b0:513:1cb0:174 with SMTP id
 q17-20020a194311000000b005131cb00174mr125439lfa.19.1710156725286; 
 Mon, 11 Mar 2024 04:32:05 -0700 (PDT)
Received: from [192.168.178.136] (port-92-192-135-113.dynamic.as20676.net.
 [92.192.135.113]) by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b00412f679bae1sm15369536wmq.26.2024.03.11.04.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 04:32:04 -0700 (PDT)
Message-ID: <f34bb533082099120ea35315bd70552820db9c57.camel@redhat.com>
Subject: Re: [PATCH v3 0/5] Generate x86 cpu features
From: Tim Wiederhake <twiederh@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Date: Mon, 11 Mar 2024 12:32:03 +0100
In-Reply-To: <ZecplxvAjp07vnQ_@redhat.com>
References: <20240206134739.15345-1-twiederh@redhat.com>
 <ZecplxvAjp07vnQ_@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 2024-03-05 at 14:17 +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Feb 06, 2024 at 02:47:34PM +0100, Tim Wiederhake wrote:
> > > > Synchronizing the list of cpu features and models with qemu is
> > > > a
> > > > recurring
> > > > task in libvirt. For x86, this is done by reading
> > > > qom-list-properties for
> > > > max-x86_64-cpu and manually filtering out everthing that does
> > > > not
> > > > look like
> > > > a feature name, as well as parsing target/i386/cpu.c for cpu
> > > > models.
> > > >=20
> > > > This is a flawed, tedious and error-prone procedure. Ideally,
> > > > qemu
> > > > and libvirt would query a common source for cpu feature and
> > > > model
> > > > related information. Meanwhile, converting this information
> > > > into an
> > > > easier
> > > > to parse format would help libvirt a lot.
> > > >=20
> > > > This patch series converts the cpu feature information present
> > > > in
> > > > target/i386/cpu.c (`feature_word_info`) into a yaml file and
> > > > adds a
> > > > script to generate the c code from this data.
> >=20
> > Looking at this fresh, I'm left wondering why I didn't suggested
> > using 'QMP' to expose this information when reviewing the earlier
> > versions. I see Igor did indeed suggest this:
> >=20
> > =C2=A0=20
> > https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg03905.html
> >=20
> > Your commentry that "qom-list-properties" doesn't distinguish
> > between CPU features and other random QOM properties is bang
> > on the money.
> >=20
> > I think what this highlights, is that 'qom-list-properties'
> > is a very poor design/fit for the problem that management apps
> > need to solve in this regard.
> >=20
> > Libvirt should not need to manually exclude non-feature properties
> > like 'check' 'enforce' 'migratable' etc.
> >=20
> > QEMU already has this knowledge, as IIUC, 'query-cpu-model-
> > expansion'
> > can distinguish this:
> >=20
> > query-cpu-model-expansion type=3Dstatic model=3D{'name':'Nehalem'}
> > {
> > =C2=A0=C2=A0=C2=A0 "return": {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "model": {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "nam=
e": "base",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "pro=
ps": {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "3dnow": false,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ...snip...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "xtpr": false
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0 }
> > }
> >=20
> > We still have the problem that we're not exposing the CPUID/MSR
> > leafs/register bits. So query-cpu-model-expansion isn't a fit
> > for the problem.
> >=20
> > Rather than try to design something super general purpose, I'd
> > suggest we take a short cut and design something entirley x86
> > specific, and simply mark the QMP command as "unstable"
> > eg a 'x-query-x86-cpu-model-features', and then basically
> > report all the information libvirt needs there.
> >=20
> > This is functionally equivalent to what you expose in the YAML
> > file, while still using QEMU's formal 'QMP' API mechanism, so
> > we avoid inventing a new API concept via YAML.
> >=20
> > I think this would avoid need to have a code generator refactor
> > the CPU definitions too. We just need to expose the values of
> > the existing CPUID_xxx constants against each register.
> >=20
> >=20
> >=20
> > With regards,
> > Daniel

Thank you for your feedback.

I do not see the patches and your proposed x-query-x86-cpu-model-
features QMP command being mutually exclusive.

In fact, I'd advocate for merging this patches still, as they provide a
solution (albeit not through QMP) already whereas the QMP command would
still need to be written. Additionally, there are more benefits to the
generate-code approach, as the code generator can be extended to also
generate the feature bits "#define CPUID_* (1U << ...)" in cpu.h,
removing one more source of errors. And with the generated
`feature_word_info` structure being virtually identical to the current
version, I see no downsides: If the generator does become obsolete in
the future, simply remove the python script and the yaml file, and all
that is left is the original feature_word_info code, but better
formatted.

Regards,
Tim


