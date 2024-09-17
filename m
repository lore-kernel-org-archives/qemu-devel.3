Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD69C35FFD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 09:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqUOw-00048N-TY; Tue, 17 Sep 2024 05:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66e945cd.v1-e27f722b0ed54d45a655e0b25a0ff57c@bounce.vates.tech>)
 id 1sqUOo-0003vx-PA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:21:31 -0400
Received: from mail178-25.suw51.mandrillapp.com ([198.2.178.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66e945cd.v1-e27f722b0ed54d45a655e0b25a0ff57c@bounce.vates.tech>)
 id 1sqUOg-0004bb-Ce
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1726563789; x=1726824289;
 bh=idgHq/67RwTh/JAU2CY11c6P488Cq/ZprPkWSuRtEWo=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=y7DvJs4Hxsn4JLVmNpGcS/U68XfUaF8rrreQqaMyfsWr57x51w/gZOLnSHh9FYoLq
 v0El7OYZSv3dYXZQ84yqoQKLXsMDq+ABBYs4JWvmTAAC/yBE7Ts9QERAyvQtHQ9xVU
 +RSEUsnJ0/m5RtsqUsa4onkOBdlhRfWiSTfIYr0jlIEAplxWaRJyX/ixNLBfgfuIn7
 TIPloBhIno21jULq+Kyf0WZ85zc/JuK4qGUx1998+0i4jSRd3SL1kDfhic5vxJY9IQ
 mbwFqGLoE4MomzdHg4Tv03iM+UtcoETYIwLHf6wxRv5pyBaSbQ568Kr/beW4sznpCZ
 dgBjw6ZpngKgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1726563789; x=1726824289; i=anthony.perard@vates.tech;
 bh=idgHq/67RwTh/JAU2CY11c6P488Cq/ZprPkWSuRtEWo=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=IdHoTxLALCDT2E/JIVanYcU0kZrwAIq3s4sQ426OmJa8dqMs2lBFidjd5tsQUkpl7
 adqVy9U8nUVDL32KENv3qqr9F7G7KhUCOL2rPHXOKRwWHfeji777GlCVsi6UQGGi8T
 +4E5l7nFqUE6E5+bDgUn3ht33YRssqhJwJKcU+o9n2UJfDiZ3YlqLJauV+bTDr/0l7
 Q1mxwbz9BXMir0N012B0C+DbI2T8EiG98bO49fnXLBUTf//AH8yxX0q68O5r1uxQu9
 Eoc3TxIpHq97xxM9l31sesKU+JRisOzYremWi7vSHyLuQESlsL+wDy5YQCYmo2Uahg
 L5xP2ulOKd3yw==
Received: from pmta13.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail178-25.suw51.mandrillapp.com (Mailchimp) with ESMTP id
 4X7G5n5cl3z4f3jsx
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:03:09 +0000 (GMT)
From: Anthony PERARD <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH]=20hw/xen:=20Remove=20deadcode?=
Received: from [37.26.189.201] by mandrillapp.com id
 e27f722b0ed54d45a655e0b25a0ff57c; Tue, 17 Sep 2024 09:03:09 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1726563788336
To: dave@treblig.org
Cc: sstabellini@kernel.org, paul@xen.org, edgar.iglesias@gmail.com,
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, anthony@xenproject.org
Message-Id: <ZulFy+S9b243+EQy@l14>
References: <20240917002212.330893-1-dave@treblig.org>
In-Reply-To: <20240917002212.330893-1-dave@treblig.org>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.e27f722b0ed54d45a655e0b25a0ff57c?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240917:md
Date: Tue, 17 Sep 2024 09:03:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.178.25;
 envelope-from=bounce-md_30504962.66e945cd.v1-e27f722b0ed54d45a655e0b25a0ff57c@bounce.vates.tech;
 helo=mail178-25.suw51.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 17, 2024 at 01:22:12AM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> xen_be_copy_grant_refs is unused since 2019's
>   19f87870ba ("xen: remove the legacy 'xen_disk' backend")
> 
> xen_config_dev_console is unused since 2018's
>   6d7c06c213 ("Remove broken Xen PV domain builder")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Acked-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 

Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

