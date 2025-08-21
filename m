Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AACCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 01:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uouAn-0006Rb-92; Wed, 20 Aug 2025 21:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uouAl-0006RI-53; Wed, 20 Aug 2025 21:32:59 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uouAj-0006g5-Ha; Wed, 20 Aug 2025 21:32:58 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-435de8160dbso178157b6e.3; 
 Wed, 20 Aug 2025 18:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755739976; x=1756344776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xyczhmlKtv1L17mdAnQ068zuyKUSxYddeRT0besMfbY=;
 b=AsGOL9b4bVHP8k8AO9RVjXc9Pgja/X0sZJTbxZgpqQhdVjjqYU0ysA5xMouKeqzW5+
 f9ews4PrOUU4qMxpYFoAs/nZE4NDlDVQSR1pnJKvZdb9/9E4q0ukRJp3KHZ70xEnGWqx
 OH3P28qlYdCb+eBet4hQklns2BuAbosiJNr2yWcAjPkbRrDhK0DqXM0rhOKR6YxsWwaN
 6mQgYC0TQ97gmSgrct/HPi1yGbfoOgDR3TzH0ZysOiKM96WUW0MeumpxiedRo41ofz1O
 +wY/9pf3UXHCjVR4HuSrWdCYY+hKaOmIipjFBiQzwI0fD7dGQ2T8axIGEPIEEyz5DTqS
 /xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755739976; x=1756344776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xyczhmlKtv1L17mdAnQ068zuyKUSxYddeRT0besMfbY=;
 b=k0MitdkZ0OiTOdQ3dS+mnneoXiGyw+O1dVKqC6sa3KfByX0WvHRUpKXOmFbb6duI6i
 7tjKkHUM54P1O0XIo4pdGwfMFfOXQ3xBCvWiXwo4CL+AjJgbNLqt4JbzrR9m5pK6XxKE
 QazuZF5cqNz2bUzLvhR9Be65ZnAQZhD77UvY8ktDL7HsTw1xYIstABoL/1oqUeAoq5Im
 iHoO4HM1UZ7ORdNx/zA/0sAllC/qalAhPzLkfSxJQDBPIw9yGaF1gn+gNkU9C8D9jUmU
 w6Zr2qtDmw2G0428LOZTQA//1Dm7d2n9gEk50zBEP5T6efrlA+k59Rl15+XJc5E/3PrS
 P2gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6tjDnAY9AMamGQHpcJaWqYuz+TFHvBR1sXA+N7TaNPqyd0aOmpFQ8fW+EJRtxZdZO5jXa0u3dNnlK@nongnu.org
X-Gm-Message-State: AOJu0YzuB+UK8mIOZfZFzd80Cjp9KQMYF9Y0s5vsh1VwEwG/tDWhp81J
 oGYgQ6txmtdtsl6G15LaKmOC0FcVPeEU0N1cgndbTuGXTBvoJYQgT1DSXStjVl/Al+4s2M26TR7
 EG4HrnBhgUfk/nlHQZN0z8sbPN/CssZM=
X-Gm-Gg: ASbGncvw7TjExLSd8/ObSo21/rpDL+TTOQ/6254Y2L7uC+hk+eNM9X59fxIwnnAFhuh
 P6dJ8iYCn1LmE9MEW1C5GiaW+O6U3j2/pqxzcyL6egs/jJBxKm8m1kAf2EYFo5jLOc0Zpp8VnhF
 n5HjX8Pia950u3Rn3Mc12POh3rmUMOwgeDlVTOBSB1t814rIfOE7RIBZGyG6DJSTswWxxCErpE9
 N/+Dhw=
X-Google-Smtp-Source: AGHT+IFzOTtft1JdzUBUOvXtUEMesya16os5JUY6ANeWDOg1jLnVinXbm/2l6khgVaYi/JEecHn7lUFsXPAW39+vABI=
X-Received: by 2002:a05:6808:2120:b0:41c:95a3:8180 with SMTP id
 5614622812f47-4377d6f6186mr374691b6e.20.1755739975824; Wed, 20 Aug 2025
 18:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250815034619.51980-1-hizhisong@gmail.com>
 <20250817134527.GA321129@fedora>
In-Reply-To: <20250817134527.GA321129@fedora>
From: Brian Song <hibriansong@gmail.com>
Date: Wed, 20 Aug 2025 21:32:44 -0400
X-Gm-Features: Ac12FXx17h2LNTHEUntF3wV3aYKqlMKtxxgtKzonv0Ya3p73Ltq9bgAt7ENdcMI
Message-ID: <CAKWCU7V4+Eu-6iVbjd+xR0yrqNShGf3y2VB_RNqXo-dP7ZMFUg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] block/export: Add FUSE-over-io_uring for Storage
 Exports
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=hibriansong@gmail.com; helo=mail-oi1-x232.google.com
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

On 8/17/25 9:45 AM, Stefan Hajnoczi wrote:
> On Thu, Aug 14, 2025 at 11:46:16PM -0400, Zhi Song wrote:
>> Due to kernel limitations, when the FUSE-over-io_uring option is
>> enabled,
>> you must create and assign nr_cpu IOThreads. For example:
>
> While it would be nice for the kernel to support a more flexible queue
> mapping policy, userspace can work around this.
>
> I think Kevin suggested creating the number of FUSE queues required by
> the kernel and configuring them across the user's IOThreads. That way
> the number of IOThreads can be smaller than the number of FUSE queues.
>
> Stefan

If we are mapping user specified IOThreads to nr_cpu queues Q, when we
register entries, we need to think about how many entries in each Q[i]
go to different IOThreads, and bind the qid when submitting. Once a CQE
comes back, the corresponding IOThread handles it. Looks like we don't
really need a round robin for dispatching. The actual question is how
to split entries in each queue across IOThreads.

For example, if we split entries evenly:

USER: define 2 IOThreads to submit and recv ring entries
NR_CPU: 4

Q = malloc(sizeof(entry) * 32 * nr_cpu);

IOThread-1:
Q[0] Q[1] Q[2] Q[3]
  16   16   16   16

IOThread-2:
Q[0] Q[1] Q[2] Q[3]
  16   16   16   16

