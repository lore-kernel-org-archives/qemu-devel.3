Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9615FC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhAiZ-0001hh-6E; Mon, 04 Mar 2024 10:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rhAiW-0001h0-SF
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:59:04 -0500
Received: from chameleon.pear.relay.mailchannels.net ([23.83.216.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rhAiT-0004aj-Go
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:59:03 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 168DE6C1370
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 15:58:56 +0000 (UTC)
Received: from outbound5d.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 9BC436C243C
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 15:58:47 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709567927; a=rsa-sha256;
 cv=pass;
 b=64Tl9caA6qqHCbVQEGAU4lunobXIEx0kpU1XoD6d7fYnKDUNvDU8jNF2FZBNTYC6O+tbyk
 ZRri/0beDjZBZRKE/nODu0TWjgd65Lbv/jxhGFv1tgKbKdZD0rKpHpxW7ToG1G3QUCrIdi
 QqpEMg1EZ9fpfh/4BxpRLMCB3xmvVSm/odt0UGt7y4jX2XlX6UN//GMvAuHBN+hEFJ/jDe
 xPy66sL+yZkyeYFCXFmQTTl1rDiLdQUkEVGEWVWgVS3I+Pj7ROoaZvIGqMoB/j6rnHaFWd
 TTitc0sJBoNh4rDnTfKszD59DFaQ9OD5DhaUG8kehOaB2S/XzGEi4sexriRIzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709567927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=xDL7RXnw5HrZgQcj/Hv5tnzmzsSyAelmOERKo0fhGjk=;
 b=0hkgPfHVKI1IopRvIpGNJWWGJAPLettugzj5jiDazGOSZ/eMb3+rp7sQ719m8Y5N1kufsR
 dt2XrjcqxBhddVV+G2sA7zan0/2XpCJCeGGxtEnLXY5Z/w96lp4XfHgkA5LAoP6besSn3P
 jpt5uGfGgOQCfVZWgcD5TClCMfTEFH9pAoLw2BWKfmjgN7XF5JODhsmf7wQCA/SrHi9xSG
 aOFLXBdU/CeDtNmbfFQVD6dQdG4AqxlC9996H1FkSXqubb0yiWJ8l3zuYucm0euJqrzz+7
 mioyLN5cTA3iZCQnvowBO/tiyKkfG5FmZozc7dAGoK+Qf0+fP5+I5b0aTa7hyw==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-pr8lr;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Society-Blushing: 190aeea76c542ea3_1709567928135_2022126092
X-MC-Loop-Signature: 1709567928135:684107121
X-MC-Ingress-Time: 1709567928134
Received: from outbound5d.eu.mailhop.org (outbound5d.eu.mailhop.org
 [3.121.156.226]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.40.12 (trex/6.9.2); Mon, 04 Mar 2024 15:58:48 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709567892; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=XGCaqzbN047rN0Mf8Qs0CVjI1OOSa/WSZzgSa7jkMUStuCa37djhbZg839NA/PO9Q8SjLKW0zFt9D
 YBKDTmyHsPQADydj+D6ONJF24YGd71ozPExcxcURMV1aa9Cfh0XTL4eOExW2npsjizMki5LwW1BPOI
 HOG3guVT0iYHt6VBddWpTieXAbdHv6Gdt9L1tHGxdden7ld2AVhZOnHXFLqJMHQKFRSV3/FwAhPlaJ
 tIk/u+zEkzdfxrDFR7uOlRAogU9MXHjKV0m4CrcXR88fZLodnR8ZcR88lb1EMKUA6A2qVbhi1i8EPk
 QRCl/ChWViDZzDJrmbV5kpIPrmpIXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=xDL7RXnw5HrZgQcj/Hv5tnzmzsSyAelmOERKo0fhGjk=;
 b=qLrldCT/sXHpX6dqk6Kxqv+f3SodDe6JqkF2ByXrJ3ZbzUFGhH5XNglaVWw0F/ttPzhuIEd1A1LZs
 t+CgE7hgqUb/gZ3l+u2fBHYIzkdRavEwxQcSESaU2A91p+DWhiixkM0UINW/4Rq8zghBIjF4pbT8VS
 gUVrud6QuZ0W9Oh1MR4QmeZoybN+JFVm2zbmCra+N65wwXCOHrtwj6bzDt/l8u1bRU8OMCCKpCF7vS
 3KzL+NUjLWFGJCYdFYwSkLyRUmnAuAieXTJfEPUZTxrwFJpB2eSjAn3pC5ov56yYULgcnPS9UmwY78
 RfCK4XbNUpcHY/YDkEEGgOrJl2QTzrw==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=lRTbK80y; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=xDL7RXnw5HrZgQcj/Hv5tnzmzsSyAelmOERKo0fhGjk=;
 b=pyNE3hpRfHEFQ+d+w/wcG1Icfr3R9ftU8JLa+JH7IX9c6vo9SZUTGQA5zfl9URFN3+lWMTk7KHpE3
 8jH6mjN7mzChbvFhBZBEQZIWtMqjzCVAk+HHzQu/EuGvf5G9pQ6JQdIUpAAMQSUyw9xU9t6Ce8DXFc
 n2ZDTGcx8RGppAGQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=xDL7RXnw5HrZgQcj/Hv5tnzmzsSyAelmOERKo0fhGjk=;
 b=ZLUldLY2q+i8xPTrRaM7HnVMImEGGltrPH11nvkY2C/v6rPQ2WAdqJGYtqL3yVxsuQghmktyokV/3
 wxJlpnhrY6+6MEB514AtzgJIvRuzBPgS5LsJY+p7LpSUR3SEG4dMKL0NTKJM3QljIkwNVd+nDMThBn
 0wa7YJJdISlgD2BuxXHanqQS19qKat8poboEVuHo+/+2f0pJsG6ABakjVEtomGnYtpuV8dg40U2tlE
 p+w5XpEKyy3UKi+Ep4nct9ZrhToEPgk+HUhSCe9gQ9jaU62hNXWrnftsKM/7QLLJnv8qKoe/nNJzGB
 z4zwXuXJmbMHUPz/eL48444S1l+I1gA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: fd4717fd-da3f-11ee-b016-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id fd4717fd-da3f-11ee-b016-eda7e384987e;
 Mon, 04 Mar 2024 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xDL7RXnw5HrZgQcj/Hv5tnzmzsSyAelmOERKo0fhGjk=; b=lRTbK80y7WUl4nz9GGrePeCQzJ
 2emuOl9LEkLy5oY0vlceaUU/rn5RWu1SGWdog1utOTuxYvOAQuD+XTF0ktNvSePknpd2TbqQBvwkQ
 RNtQdoIQbf/kry5Pckx5g5w6FLA6s1Ca2Q+mj6DDirPZEoDRtT5bQGZX6TGtCHnZzRjc7Kb+6+kCP
 SsmjLvISn8LY5UNfFOS+0d/uvT/8A57uJCvu4HiyhGAYMUIYq3OMO7zNKS/zUazVF5VWnzQ0pwVqy
 hfZNlzyLufdhiTn54oYuBokl3HNPSlGqWTgeUZoUU17FJwqhXD7jQRymI6st+wjg0ETMrg3EYiV5X
 ZTOKbXZQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rhAhz-00197F-2g;
 Mon, 04 Mar 2024 16:58:31 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org,  deller@gmx.de,  BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2] hw/scsi/lsi53c895a: add timer to scripts processing
In-Reply-To: <CAFEAcA9NSNVkZdtqF=aw=eB=MpsHTFoH6Z1CQtiabn5mme092w@mail.gmail.com>
 (Peter Maydell's message of "Mon, 4 Mar 2024 15:08:37 +0000")
References: <20240229204407.1699260-1-svens@stackframe.org>
 <CAFEAcA9NSNVkZdtqF=aw=eB=MpsHTFoH6Z1CQtiabn5mme092w@mail.gmail.com>
Date: Mon, 04 Mar 2024 16:58:31 +0100
Message-ID: <87frx6ugyg.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.33; envelope-from=svens@stackframe.org;
 helo=chameleon.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 29 Feb 2024 at 20:44, Sven Schnelle <svens@stackframe.org> wrote:
>>
>> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
>> under certain circumstances. As the SCSI controller and CPU are not
>> running at the same time this loop will never finish. After some
>> time, the check loop interrupts with a unexpected device disconnect.
>> This works, but is slow because the kernel resets the scsi controller.
>> Instead of signaling UDC, start a timer and exit the loop. Until the
>> timer fires, the CPU can process instructions which might changes the
>> memory location.
>>
>> The limit of instructions is also reduced because scripts running on
>> the SCSI processor are usually very short. This keeps the time until
>> the loop is exit short.
>
> "exited"
>
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> ---
>> Changes in v2:
>> - update comment in lsi_execute_script()
>> - reset waiting state and del timer in lsi_execute_script() to
>>   handle the case where script processing is triggered via
>>   register write, and not from the pending timer
>> - delete timer in lsi_scsi_exit()
>
> Other than the s/host/guest/ comment fix,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> I don't suppose anybody has a setup with the Windows drivers
> to test this on? (commit ee4d919f30f13 suggests that at least
> Windows XP and 2003 had this problem.)

I have a Windows XP VM with lsi53c895a. I just fired it up and added
a qemu_log() in the timer path, and seen it trigger once while copying
a few files. It looks like Windows XP (or better the SCSI driver) also
works with this patch.

