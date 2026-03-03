Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4193CEDEBE2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUDd-0005SK-EF; Tue, 03 Mar 2026 13:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxUDa-0005RJ-Dm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:11:38 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxUDY-00038H-Dp
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=y91SuI8rckf2DY6yWHLF5dam9TgAwFsi//VDqnCY4jE=; b=HAAM3K3KQVR0IRW
 6oGkCHH+0t8GH8HvXRshOyrtCQYArejOQsvnsWQWPJ5JMO6FJZzuvdlN3uGDHLB4ugETw+AJFeEIc
 wqGxDVJzYCFqk/yKguGZ84ypEH6+J5i/fYfbWKdsnwCkRts3f5K5b3GKstTbh/X08zhQhLNGQHMov
 RY=;
Date: Tue, 3 Mar 2026 19:15:10 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: Re: [PATCH v3 04/37] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Message-ID: <aacknZiSQhhIaS-8@hive.localdomain>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-5-brian.cain@oss.qualcomm.com>
 <d949b2f4-d31a-4890-8e27-6f05e9977323@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d949b2f4-d31a-4890-8e27-6f05e9977323@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/02/26, Philippe Mathieu-Daudé wrote:
> On 27/2/26 21:35, Brian Cain wrote:
> > From: Brian Cain <bcain@quicinc.com>
> > 
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   target/hexagon/hex_common.py | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> > index c0e9f26aebe..63f83a8de2a 100755
> > --- a/target/hexagon/hex_common.py
> > +++ b/target/hexagon/hex_common.py
> > @@ -247,7 +247,11 @@ def need_next_PC(tag):
> >   def need_pkt_has_multi_cof(tag):
> > -    return "A_COF" in attribdict[tag]
> > +    if "A_JUMP" in attribdict[tag] or "A_CALL" in attribdict[tag]:
> > +        if tag == "J4_hintjumpr":
> > +            return False
> > +        return True
> 
> Alternatively:
> 
>        if attribdict[tag] in ['A_JUMP', 'A_CALL']:
>            return tag != "J4_hintjumpr"

I don't think this is valid, but set intersection would work

       if attribdict[tag] & {'A_JUMP', 'A_CALL'}:
           return tag != "J4_hintjumpr"
       return False

-- 
Anton Johansson
rev.ng Labs Srl.

