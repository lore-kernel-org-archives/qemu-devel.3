Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA5ECD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZU80-0002C3-W4; Tue, 16 Jun 2026 09:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wZU7v-0002Bd-Mr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:46:51 -0400
Received: from out-179.mta1.migadu.com ([2001:41d0:203:375::b3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wZU7r-0004GA-Mz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:46:50 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781617601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6A/v0v0NNN7dzQ8Ajqsz3CqsjJ+V8Ilr1nT2Fz9k98=;
 b=nzkZvR3O4+IRB+PkBSME1O0LnnOjS7lBlMq/tc8DtyhSETsUZ1MhlZSrJ29h+FvEIqZh/o
 y35LHMpQVC8omHysufZqAOcONxGgGXPeoQUBfs0EhwQtHtCs8E0LHo7KJC3SN+UOraI1Kt
 zYX0KpxcRIx86qWo/MpwV4CWxJPMth0=
From: Tao Cui <cui.tao@linux.dev>
To: gaosong@loongson.cn
Cc: cohuck@redhat.com, cui.tao@linux.dev, cuitao@kylinos.cn,
 kvm@vger.kernel.org, maobibo@loongson.cn, mst@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] target/loongarch: PV TLB flush advertisement
Date: Tue, 16 Jun 2026 21:46:21 +0800
Message-ID: <20260616134621.114322-1-cui.tao@linux.dev>
In-Reply-To: <636afc5b-968a-3027-8683-21df1c14838a@loongson.cn>
References: <636afc5b-968a-3027-8683-21df1c14838a@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b3;
 envelope-from=cui.tao@linux.dev; helo=out-179.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Hi Song,

Thanks for the suggestion.

Bibo has also raised a few comments on the KVM side that require some
adjustments to the paired kernel series. I'll rework the series
accordingly and regenerate the linux-headers via
scripts/update-linux-headers.sh in the next version, along with those
changes.

Thanks,
--
Tao

> Hi, you should use scripts/update-linux-headers.sh to update the
> linux-headers.
>


