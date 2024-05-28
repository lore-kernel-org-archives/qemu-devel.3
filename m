Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C76C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBt3S-00076F-If; Tue, 28 May 2024 05:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sBt3Q-00075o-IH
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sBt3P-00047F-1K
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716888213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GiIG3EFPZ0dBuuM8Q/iUmKqxSxvg75nmSJ1FT+F9AGU=;
 b=cARBdFTsTVmBOE/5SAyT7Q3MgmR/QqfiKZrNZQV6GGLuWnxXIkmigtjqNi0Q190ikh3/Es
 WldDOIta0m0aOtoS8zWjJaarrbSI48OzpE81GI74nPIeUiFxsFySn1/7U30/HH2q98bgGD
 ky7/YYXOuMI2DgPV1sunGjfzPwQQH+A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-lFyGr6K5N6ebHhUx4rayKA-1; Tue, 28 May 2024 05:23:32 -0400
X-MC-Unique: lFyGr6K5N6ebHhUx4rayKA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3580f213373so483614f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 02:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716888211; x=1717493011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GiIG3EFPZ0dBuuM8Q/iUmKqxSxvg75nmSJ1FT+F9AGU=;
 b=cYIQyhzBXeTfntYv61yGDk3UVViyAqVGewXHW/wHCNLPEO6r5ci3VlKpk8EQlWQWqN
 XOL8xD/CWk/6Vh+3BDCgUcQmmHJrWpxUteUzZx1AdOelIawKAzqB3Pgk7Zh5G6T3Q2tl
 dnCTrD0B+ouQMtrybI6HDgJ7ngo8ppW2AvlMBu9l+zMYudeBmEpEuuuRLFBu7ZEQMNL9
 zyUyAHpxAK8j0eR9LDjnID7zMk5qNNAEv9dJ2vI9PuJ6i4R+JC45yx7VcOlIvqnh7eUY
 NtS7gu72sGGDo3mDWNWpcJFI2EJPwMwh0rQvg+BBxuJmxw7BQZzIx8WmIl9tUEUR+oxQ
 eXvw==
X-Gm-Message-State: AOJu0YzEoLpBEahW/SU/AKNqw1KDmOajUHPSNoj4eMkN4xTKPxjiKkY3
 8j4HI3WotLTnagFGNKjrFjxEcqfkIjUW1Yy4AewgTgwGt5MLG9chEp3uIKERTbaUuourfy9a+vw
 w0FJCh7hIm6Kv3N4OYhFP3Zm2WaKTy/15scIFhvsOGLnwACH/WBSg
X-Received: by 2002:a05:600c:54cc:b0:419:f630:57c2 with SMTP id
 5b1f17b1804b1-421089f98d1mr89362965e9.37.1716888210924; 
 Tue, 28 May 2024 02:23:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPlszxcSL842gGYVO5cN2F4JY8z8RF3aRn4CMl2XzfMw5gxlI5PzYGovCP7YNkPOim6kLEwg==
X-Received: by 2002:a05:600c:54cc:b0:419:f630:57c2 with SMTP id
 5b1f17b1804b1-421089f98d1mr89362855e9.37.1716888210608; 
 Tue, 28 May 2024 02:23:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210897bc02sm135851425e9.22.2024.05.28.02.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 02:23:30 -0700 (PDT)
Date: Tue, 28 May 2024 11:23:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH V2 0/3] improve -overcommit cpu-pm=on|off
Message-ID: <20240528112327.634e95a6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240524200017.150339-1-zide.chen@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Fri, 24 May 2024 13:00:14 -0700
Zide Chen <zide.chen@intel.com> wrote:

> Currently, if running "-overcommit cpu-pm=on" on hosts that don't
> have MWAIT support, the MWAIT/MONITOR feature is advertised to the
> guest and executing MWAIT/MONITOR on the guest triggers #UD.

this is missing proper description how do you trigger issue
with reproducer and detailed description why guest sees MWAIT
when it's not supported by host.

> 
> V2:
> - [PATCH 1]: took Thomas' suggestion for more generic fix
> - [PATCH 2/3]: no changes
> 
> Zide Chen (3):
>   vl: Allow multiple -overcommit commands
>   target/i386: call cpu_exec_realizefn before x86_cpu_filter_features
>   target/i386: Move host_cpu_enable_cpu_pm into kvm_cpu_realizefn()
> 
>  system/vl.c               |  4 ++--
>  target/i386/cpu.c         | 24 ++++++++++++------------
>  target/i386/host-cpu.c    | 12 ------------
>  target/i386/kvm/kvm-cpu.c | 12 +++++++++---
>  4 files changed, 23 insertions(+), 29 deletions(-)
> 


