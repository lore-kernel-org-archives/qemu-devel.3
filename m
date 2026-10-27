Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EMLjalLG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiok-0002HI-4o; Tue, 27 Oct 2026 11:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLio2-0001w1-Vo
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLio0-0000jS-Bt
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793113779;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxsqXTT/2SkHCopDBU3zcdHUWKG0aEgc5S4iUgZigFw=;
 b=EMLjalLGTYrNlCmGo2atTSKdh+ic+WcxN8E92twoOTqF6Og6d7Ro1qC5G68B9x+KITzduw
 qiYY1++St98785pl7l2SO/CwiUAv/+7ZqPLTHo6xDN2dpBAexTzzjZeL5IPdb2fNqv7OC5
 4yce7LK74VH32Pa60OAsm6URxDJgQqY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-7XFlFRhPPtuZJx-cX-8Sxg-1; Tue,
 27 Oct 2026 11:09:34 -0400
X-MC-Unique: 7XFlFRhPPtuZJx-cX-8Sxg-1
X-Mimecast-MFC-AGG-ID: 7XFlFRhPPtuZJx-cX-8Sxg_1793113770
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46A391954B0B; Tue, 27 Oct 2026 15:09:28 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E918918002B1; Tue, 27 Oct 2026 15:09:01 +0000 (UTC)
Date: Tue, 27 Oct 2026 15:08:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org,
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Alistair Francis <alistair@alistair23.me>,
 Alexander Graf <graf@amazon.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>,
 Luc Michel <luc@lmichel.fr>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Peter Xu <peterx@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 xen-devel@lists.xenproject.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>,
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Auger <eric.auger@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v7 54/65] qdev: adjust PciDevfn declared type
Message-ID: <auC-ilqUJq27neSR@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <20261020-qom-qapi-v7-54-431a86b02b58@redhat.com>
 <atsxLV5YZo8dr-8G@redhat.com>
 <CAMxuvazd7G_NBOM_c6BxZn5PFSw=XQUHueHqBoQQfpzPPgi9qA@mail.gmail.com>
 <87zevz5h4k.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zevz5h4k.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 03:54:03PM +0100, Markus Armbruster wrote:
> Marc-André Lureau <marcandre.lureau@redhat.com> writes:
> 
> > Hi
> >
> > On Fri, Oct 23, 2026 at 2:04 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>
> >> On Tue, Oct 20, 2026 at 02:46:11PM +0400, Marc-André Lureau wrote:
> >> > PciDevfn is a bit special, since it accepts integer and string as
> >> > setter, but only output integer as getter.

snip

> >                                                       But I agree we
> > could do better.
> >
> > There are multiple options. We could keep declaring the property as
> > str instead. In this case, the getter should probably return a string
> > for consistency and correctness. This might surprise some existing
> > users though.
> 
> I.e. ditch numeric suppport for numeric addresses, right?
> 
> Incompatible change.  Do we care?
> 
> If we don't, we should be honest about it and mark qom-get unstable.
> 
> > We could introduce new properties like `devfn-str` and `devfn-int`
> > that alias the same value.
> 
> Compatibility break.  If breaking compatibility is okay, I'd rather use
> the opportunity to get rid of cleverness, and go with your first option.
> 
> > We could also introduce a new structured QAPI type.
> 
> What kind of type do you have in mind?

IMHO the root cause design flaw here was to overload 'addr' as a
way to set both the slot number and function number, as using
one property for two pieces of data is a well known anti-pattern
we caution against.

IOW, we should have had 'slot' and 'function' as separate properties
from the start.

From a CLI POV, we could easily change 'addr' to mean only the slot
number, since it is always parsed in string format without the
magic (slot << 4) | function encoding. Then add a 'function' prop

The challenge is the impact on QMP with strict typing, as ideally
int format would soley represent the slot number, but today the
int format is encoded (slot << 4) | function.  So anyone relying
on int format in QMP would silently have a semantic change if we
altered what 'addr' means. 

Deprecating 'addr' entirely and adding brand new 'slot' and
'function' properties would be a significant disruption to
a syntax which has been documented for years (decades).


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


