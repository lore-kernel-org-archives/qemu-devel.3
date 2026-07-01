Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604A7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuUr-0001pA-FL; Wed, 01 Jul 2026 08:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.fpxx3c6enf87175=gkumg2t2mbfe=xnr40pq9b0df91@em1175899.techtravels.org>)
 id 1weuUm-0001od-Ag
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:56:53 -0400
Received: from a4i502.smtp2go.com ([158.120.81.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.fpxx3c6enf87175=gkumg2t2mbfe=xnr40pq9b0df91@em1175899.techtravels.org>)
 id 1weuUj-000161-6q
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1782910595; h=from :
 subject : to : message-id : date;
 bh=+bJzGEENgU2/FSA08fG53bKqBI3HWVmth5fc2wWDh0s=;
 b=VbxM2B2O1040NFbNq1cfMJ3gdw2VjCIs/NjnVrlFAg4iCZQQMH+qAw6aR4EQsS4g/fV6D
 95e1EWa+lwmrf04rZKyDSi+r+tskspq0ltwXp9IZ4z6V0gR1kXsoQRVNzpkICaFbbGSjyUs
 tNy93c0jIGp3X5b/Nw9cw94qTpFi0tpicuYSuNLU34toxC413uIwK8+PdTaXgsuSaLoF28x
 C3NByzMgGPe9VcdeQM2h6FXp42HfN5bYpRa4XDhFysWYgeo+Gmv8VunKN3j3eZ/SqFrhjQX
 YnAzQVqNTI+153bIOyqECMoxn1qGGbEwZYcI/9W7eCs1W1MPySLI4ubFNl3Q==
Received: from [10.91.249.253] (helo=boxtwo.techtravels.org)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1weuUR-FnQW0hPqdqR-wSCA; Wed, 01 Jul 2026 12:56:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=techtravels.org;
 s=mail; t=1782910588;
 bh=Ptqc5SBKqpRueh3A37xxd/N2TZKbpd7SMWJzal+V85A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ghng0XEtjxlmhdGJfBFDjVObi5FMSJ0CKNUgMfnOUbbeAuIzy+Ov1CwQrdWRHXtk7
 JWpn5l5guksycm7rFPGic6nXztgLSBvNe6/QFwwAqwjXjBa7hfxl5u3UEI7hyfkvWc
 X4upnEpmXK9MaGJt7WlXcIlYee4JhpBjkPw5EzZ8d/ehVXDrOIsQeov72GXysQlFRV
 XD8i1MHUgt/9Ys+et83A1IGbgWY3cilD7VuB6Y8cZ97pBjj5ss3x3h6MCkTNV0b9XJ
 vZ+recY/n/viNzYiabdD88jhHM147kkaAMoewmcZBOiJ8i6MVl4OnuWQRYOg2RAbHr
 vp+wn6WIUIOOQ==
Received: from authenticated-user (boxtwo.techtravels.org [54.196.37.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by boxtwo.techtravels.org (Postfix) with ESMTPSA id 1FB653F1AC;
 Wed,  1 Jul 2026 08:56:28 -0400 (EDT)
Message-ID: <f0ad356a-8cff-4012-95ce-76a3cd0d9feb@techtravels.org>
Date: Wed, 1 Jul 2026 08:56:28 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] hw/scsi/ncr53c710: rewrite to support HP-UX, Linux
 and NetBSD
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260701031803.1817812-1-keith@techtravels.org>
 <c8135914-92ad-4c8e-81a1-d6fca4af06eb@gmx.de>
Content-Language: en-US
From: Keith Monahan <keith@techtravels.org>
In-Reply-To: <c8135914-92ad-4c8e-81a1-d6fca4af06eb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aieqF3d:1175899sXG8xwGsle
X-smtpcorp-track: a6uM0LuxzDt_.qzMvxu9rDr-Y.JNma-AeUTDD
Received-SPF: pass client-ip=158.120.81.246;
 envelope-from=bounce.fpxx3c6enf87175=gkumg2t2mbfe=xnr40pq9b0df91@em1175899.techtravels.org;
 helo=a4i502.smtp2go.com
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

On 7/1/2026 8:40 AM, Helge Deller wrote:

> Thanks for this series!!!
> I've tested this driver with HP-UX 10.20 (which didn't worked with the 
> previous
> ncr710 driver yet), and it's a big step forward.
> Thanks for doing this.

You're welcome! Thanks for working with me on this! This LASI NCR710 
support for HP-UX is a feature I've wanted for years, so I'm glad to had 
the time to bring it life!

Keith


