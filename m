Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2931F483E4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4kNB-0003yd-6d; Mon, 23 Mar 2026 14:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w4kN5-0003sN-FQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 14:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w4kN2-0007Ks-MR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 14:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774291883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oZ0P3F0LTW02JQ3N8Byicn6pS46ujKJnI4Cb5Xq9t5M=;
 b=bNp3MBACSHrFry5K8YXyPvlz3SQ918vI2HQO7Y+zVEgiHl9yxKSCWK35meEwD+2ciDIgF3
 /hjpWIdKBzv1ImJ3GJ4UGdaxsSryXoR7I05ZxjV2zDbBR04rFylcyOjoZqL+yhiHgt4UUz
 egxWz+jCQUai7WGelG70Mrqcsahtv0I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-0C0dw-XJPE2K_PbdyFnDWg-1; Mon,
 23 Mar 2026 14:51:16 -0400
X-MC-Unique: 0C0dw-XJPE2K_PbdyFnDWg-1
X-Mimecast-MFC-AGG-ID: 0C0dw-XJPE2K_PbdyFnDWg_1774291874
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7598180034F; Mon, 23 Mar 2026 18:51:13 +0000 (UTC)
Received: from localhost (unknown [10.44.32.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1AD161955D71; Mon, 23 Mar 2026 18:51:11 +0000 (UTC)
Date: Mon, 23 Mar 2026 14:51:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
Message-ID: <20260323185109.GB631609@fedora>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260219222717.GA1011077@fedora>
 <79c89de8-68f4-46ff-bcce-dcb817d04ad5@linux.ibm.com>
 <5a50568c-d7c8-4938-b399-b304c162f6f2@linux.ibm.com>
 <e2fc5d97-af5b-4a8a-8a51-50bc108d969d@linux.ibm.com>
 <63173e58-6c6e-4f69-a80d-8ddc4b372198@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wrk7U+tg6x4DUmcA"
Content-Disposition: inline
In-Reply-To: <63173e58-6c6e-4f69-a80d-8ddc4b372198@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Wrk7U+tg6x4DUmcA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 09:08:13AM -0500, JAEHOON KIM wrote:
> On 3/9/2026 3:46 PM, JAEHOON KIM wrote:
> > On 2/26/2026 12:03 AM, JAEHOON KIM wrote:
> > > On 2/20/2026 1:00 PM, JAEHOON KIM wrote:
> > > > On 2/19/2026 4:27 PM, Stefan Hajnoczi wrote:
> > > > > Hi Jaehoon,
> > > > > Following the call earlier this week I ran a single fio job to ge=
t a
> > > > > clearer picture of:
> > > > > 1. The QEMU 10.0.0 regression that prompted you to optimize AioCo=
ntext
> > > > > =C2=A0=C2=A0=C2=A0 polling.
> > > > > 2. How the poll-weight parameter affects IOPS.
> > > > >=20
> > > > > run=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rw=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bs=C2=A0=C2=A0 numjobs iothreads iops=C2=A0=C2=A0 diff
> > > > > v9.2.0=C2=A0=C2=A0 randread=C2=A0 8k=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 174=
944 3.6%
> > > > > v10.0.0=C2=A0 randread=C2=A0 8k=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 174285=
 3.2%
> > > > > baseline randread=C2=A0 8k=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 168908 0.0%
> > > > > w2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 randread=C2=A0 8k=C2=A0=C2=
=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 163718 -3.1%
> > > > > w3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 randread=C2=A0 8k=C2=A0=C2=
=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 165805 -1.8%
> > > > > w4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 randread=C2=A0 8k=C2=A0=C2=
=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 167388 -0.9%
> > > > >=20
> > > > > This time I only ran randread bs=3D8k iodepth=3D8 numjobs=3D1 wit=
h a single
> > > > > IOThread.
> > > > >=20
> > > > > Observations:
> > > > >=20
> > > > > - There might be an IOPS regression between v10.0.0 and the basel=
ine
> > > > > =C2=A0=C2=A0 (9ad7f544c696) that your patches apply on top of. Th=
is is different
> > > > > =C2=A0=C2=A0 from the CPU utilization regression that you found i=
n v9.2.0 ->
> > > > > =C2=A0=C2=A0 v10.0.0. I will bisect it.
> > > > >=20
> > > > > - poll-weight=3D3 and 4 improve IOPS to a level that is acceptabl=
e. CPU
> > > > > =C2=A0=C2=A0 utilization looks like this:
> > > > >=20
> > > > > run=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %usr=C2=A0=C2=
=A0=C2=A0=C2=A0 %nice=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %sys=C2=A0=C2=A0 %iowai=
t=C2=A0=C2=A0=C2=A0 %steal
> > > > > %irq=C2=A0=C2=A0=C2=A0=C2=A0 %soft=C2=A0=C2=A0=C2=A0 %guest=C2=A0=
=C2=A0=C2=A0 %gnice=C2=A0=C2=A0=C2=A0=C2=A0 %idle
> > > > > baseline=C2=A0=C2=A0 49.37=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=
=A0=C2=A0=C2=A0=C2=A0 31.10=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0.00
> > > > > 11.61=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.04=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 7.89
> > > > > w2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 46.24=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0 32.61=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00
> > > > > 11.84=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.10=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 9.21
> > > > > w3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 48.04=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0 32.17=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00
> > > > > 11.98=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.08=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 7.73
> > > > > w4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 48.56=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0 31.23=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00
> > > > > 11.48=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.03=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 8.69
> > > > >=20
> > > > > poll-weight=3D2 is the winner at CPU utilization. I'm not sure if
> > > > > poll-weight=3D3 will produce an acceptable CPU utilization
> > > > > improvement for
> > > > > you. Do you have data or want to re-run to measure poll-weight=3D=
3?
> > > > >=20
> > > > > Stefan
> > > >=20
> > > > Thank you very much for sharing the detailed measurement results.
> > > > I truly appreciate the effort.
> > > >=20
> > > > Regarding w=3D3, I will discuss with our performance team to see
> > > > if the CPU consumption levels are acceptable within our internal
> > > > test environment. I will get back to you with more definitive data
> > > > as soon as possible.
> > > >=20
> > > > Thanks again for your thorough analysis.
> > > >=20
> > > > Regards,
> > > > Jaehoon.
> > > >=20
> > > Hello Stefan,
> > >=20
> > > Thank you for your patience. I would like to share the observed
> > > changes in throughput
> > > and CPU consumption in our performance test environment as follows.
> > >=20
> > > We observed that when using W=3D3, performance returns to a level
> > > comparable to
> > > QEMU v9.1, while W=3D2 results in slightly lower CPU consumption.
> > >=20
> > > Our initial preference is to use W=3D2 by default.
> > > However, we fully understand your concerns regarding the potential
> > > performance drop.
> > > Should the patch be accepted, we would provide guidance on using the
> > > weighted value as
> > > a configurable option.
> > >=20
> > > For reference, we consider values between -2 and 2 as noise in our
> > > analysis.
> > > I look forward to your feedback.
> > >=20
> > > The table below shows a comparison between:
> > > *=C2=A0 - Host:* RHEL10.1-GA+qemu-10.0.0-14.el10_1, *Guest:* RHEL 9.6=
 GA vs.
> > > *=C2=A0 - Host:*=C2=A0RHEL10.1-GA+qemu-10.0.0-14.el10_1 (w=3D2, w=3D3=
), *Guest:*
> > > RHEL 9.6 GA
> > > =C2=A0 =C2=A0 for FIO FCP and FICON with 1 iothread and 8 iothreads.
> > > =C2=A0 =C2=A0 The values shown are the averages for numjobs 1, 4, and=
 8.
> > >=20
> > > FIO FCP -1 iothread
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| Seq. Read=C2=A0 | Seq. Read=C2=A0 | Seq. Write | Seq.
> > > Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =C2=
=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0| =C2=A0w3
> > > (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=
=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =
=C2=A0|
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > | Throughput avg=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0-3.00=C2=A0 =C2=A0=
 |=C2=A0 =C2=A0-2.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0 0.00=C2=A0 =C2=A0 |
> > > =C2=A0-0.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-3.00=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0-3.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.33=
=C2=A0 =C2=A0 |
> > > | CPU consumption avg |=C2=A0 =C2=A0-5.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0=
-4.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-6.33=C2=A0 =C2=A0 |
> > > =C2=A0-5.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-7.33=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0-5.33=C2=A0 =C2=A0 |=C2=A0 -10.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-8.67=C2=A0=
 =C2=A0 |
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > >=20
> > > FIO FCP -8 iothread
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| Seq. Read=C2=A0 | Seq. Read=C2=A0 | Seq. Write | Seq.
> > > Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =C2=
=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0| =C2=A0w3
> > > (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=
=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =
=C2=A0|
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > | Throughput avg=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0-5.00=C2=A0 =C2=A0=
 |=C2=A0 =C2=A0-4.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-3.67=C2=A0 =C2=A0 |
> > > =C2=A0-3.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-4.67=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0-4.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.67=
=C2=A0 =C2=A0 |
> > > | CPU consumption avg |=C2=A0 -13.00=C2=A0 =C2=A0 |=C2=A0 -10.67=C2=
=A0 =C2=A0 |=C2=A0 -16.00=C2=A0 =C2=A0 |
> > > -14.33=C2=A0 =C2=A0 |=C2=A0 -14.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-9.33=
=C2=A0 =C2=A0 |=C2=A0 -13.67=C2=A0 =C2=A0 |=C2=A0 -11.00=C2=A0 =C2=A0 |
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > >=20
> > >=20
> > > FIO FICON -1 iothread
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| Seq. Read=C2=A0 | Seq. Read=C2=A0 | Seq. Write | Seq.
> > > Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =C2=
=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0| =C2=A0w3
> > > (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=
=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =
=C2=A0|
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > | Throughput avg=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.67=C2=A0 =C2=A0=
 |=C2=A0 =C2=A0-0.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0-6.33=C2=A0 =C2=A0 |
> > > =C2=A0-6.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.67=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 0.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1.33=
=C2=A0 =C2=A0 |
> > > | CPU consumption avg |=C2=A0 =C2=A0-7.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0=
-7.33=C2=A0 =C2=A0 |=C2=A0 -13.67=C2=A0 =C2=A0 |
> > > -13.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-9.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-8=
=2E33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-5.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-4.33=C2=
=A0 =C2=A0 |
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > >=20
> > > FIO FICON -8 iothread
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| Seq. Read=C2=A0 | Seq. Read=C2=A0 | Seq. Write | Seq.
> > > Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =C2=
=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0| =C2=A0w3
> > > (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=
=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =
=C2=A0|
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > | Throughput avg=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0-3.00=C2=A0 =C2=A0=
 |=C2=A0 =C2=A0-2.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0-7.33=C2=A0 =C2=A0 |
> > > =C2=A0-7.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.67=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0-1.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0 0.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0 0.67=
=C2=A0 =C2=A0 |
> > > | CPU consumption avg |=C2=A0 -16.33=C2=A0 =C2=A0 |=C2=A0 -14.33=C2=
=A0 =C2=A0 |=C2=A0 -25.33=C2=A0 =C2=A0 |
> > > -27.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-8.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0-7=
=2E00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-6.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0-5.00=C2=
=A0 =C2=A0 |
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > >=20
> > >=20
> > > The table below shows a comparison between:
> > > *=C2=A0- Host:* RHEL 10.0 GA + qemu-9.1.0-15.el10, *Guest:* RHEL 9.6 =
GA vs.
> > > *=C2=A0- Host:* RHEL 10.1 GA + qemu-10.0.0-14.el10_1 (w=3D2, w=3D3), =
*Guest:*
> > > RHEL 9.6 GA.
> > >=20
> > > FIO FCP -1 iothread
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| Seq. Read=C2=A0 | Seq. Read=C2=A0 | Seq. Write | Seq.
> > > Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =C2=
=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0| =C2=A0w3
> > > (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=
=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =
=C2=A0|
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > | Throughput avg=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.67=C2=A0 =C2=A0=
 |=C2=A0 =C2=A0 0.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.33=C2=A0 =C2=A0 |
> > > =C2=A0-1.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-1.00=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0-0.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0 3.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0 2.00=
=C2=A0 =C2=A0 |
> > > | CPU consumption avg |=C2=A0 =C2=A0 0.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0=
 2.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1.67=C2=A0 =C2=A0 | 3.00=C2=A0
> > > =C2=A0 |=C2=A0 =C2=A0-3.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.33=C2=A0 =C2=
=A0 |=C2=A0 =C2=A0-2.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0 0.00=C2=A0 =C2=A0 |
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > >=20
> > > FIO FCP -8 iothread
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| Seq. Read=C2=A0 | Seq. Read=C2=A0 | Seq. Write | Seq.
> > > Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =C2=
=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0| =C2=A0w3
> > > (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=
=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =
=C2=A0|
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > | Throughput avg=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0-2.00=C2=A0 =C2=A0=
 |=C2=A0 =C2=A0-1.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-1.00=C2=A0 =C2=A0 | 0.00=
=C2=A0
> > > =C2=A0 |=C2=A0 =C2=A0-0.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1.00=C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 1.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0 0.67=C2=A0 =C2=A0 |
> > > | CPU consumption avg |=C2=A0 =C2=A0-3.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0=
-1.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-2.00=C2=A0 =C2=A0 | 0.00=C2=A0
> > > =C2=A0 |=C2=A0 -10.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-5.67=C2=A0 =C2=A0 |=
=C2=A0 =C2=A0-6.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0-3.33=C2=A0 =C2=A0 |
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > >=20
> > >=20
> > > FIO FICON -1 iothread
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| Seq. Read=C2=A0 | Seq. Read=C2=A0 | Seq. Write | Seq.
> > > Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =C2=
=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0| =C2=A0w3
> > > (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=
=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =
=C2=A0|
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > | Throughput avg=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0-1.67=C2=A0 =C2=A0=
 |=C2=A0 =C2=A0-1.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.33=C2=A0 =C2=A0 | 0.00=
=C2=A0
> > > =C2=A0 |=C2=A0 =C2=A0-1.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-1.00=C2=A0 =C2=
=A0 |=C2=A0 =C2=A0-1.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0-2.33=C2=A0 =C2=A0 |
> > > | CPU consumption avg |=C2=A0 =C2=A0-0.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0=
 1.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1.00=C2=A0 =C2=A0 | 2.00=C2=A0
> > > =C2=A0 |=C2=A0 =C2=A0-2.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-1.33=C2=A0 =C2=
=A0 |=C2=A0 =C2=A0-1.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.33=C2=A0 =C2=A0 |
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > >=20
> > > FIO FICON -8 iothread
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| Seq. Read=C2=A0 | Seq. Read=C2=A0 | Seq. Write | Seq.
> > > Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
> > > |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =C2=
=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0| =C2=A0w3
> > > (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=
=C2=A0 =C2=A0|=C2=A0 =C2=A0w2 (%)=C2=A0 =C2=A0|=C2=A0 =C2=A0w3 (%)=C2=A0 =
=C2=A0|
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > > | Throughput avg=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0-1.00=C2=A0 =C2=A0=
 |=C2=A0 =C2=A0-0.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0-0.33=C2=A0 =C2=A0 | 0.33=
=C2=A0
> > > =C2=A0 |=C2=A0 =C2=A0 0.67=C2=A0 =C2=A0 |=C2=A0 =C2=A0 0.33=C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 0.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0 0.33=C2=A0 =C2=A0 |
> > > | CPU consumption avg |=C2=A0 =C2=A0-1.33=C2=A0 =C2=A0 |=C2=A0 =C2=A0=
 1.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0 4.33=C2=A0 =C2=A0 | 2.33=C2=A0
> > > =C2=A0 |=C2=A0 =C2=A0-2.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0 0.00=C2=A0 =C2=
=A0 |=C2=A0 =C2=A0-3.00=C2=A0 =C2=A0 |=C2=A0 =C2=A0-1.33=C2=A0 =C2=A0 |
> > > +---------------------+------------+------------+------------+-------=
-----+------------+------------+------------+------------+
> > >=20
> > >=20
> > >=20
> > > Regards,
> > > Jaehoon.
> > >=20
> > >=20
> > Hello Stefan,
> >=20
> > I=E2=80=99m following up to see if you=E2=80=99ve had a chance to revie=
w the performance
> > results I shared.
> > As I mentioned, we are completely fine with using w=3D3 as the default
> > value.
> > It effectively restores performance to QEMU v9.1 levels, and we will
> > provide guidance
> > for users who need further CPU savings to use w=3D2.
> >=20
> > I=E2=80=99ve updated the patch to set the default value to 3 and includ=
e the
> > feedback so far.
> > Please let me know if you have any comments or if I should post the new
> > patch.
> >=20
> > Regards,
> > Jaehoon
> >=20
> >=20
> Hello,
>=20
> I'd like to follow up on this thread. I have posted a v2 incorporating the
> feedback so far.
> I'd really appreciate your thoughts when you have a chance.
>=20
> Thanks again for your time.

Hi Jaehoon,
Sorry that I haven't replied yet. I will review your emails and the v2
patches tomorrow.

Stefan

--Wrk7U+tg6x4DUmcA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnBi50ACgkQnKSrs4Gr
c8gnmAgAg3miVGla9LThE7mwTfweZa9D7sMmsRTdnOQWvYQjoiAlSA5XRwa/vYXM
FM3Z8wZ0VfOC9ScjYwztaNW5v53UMCljB5omueDkI7Pa2pJM0Da3uy+9f7OXJi9Y
DfG6v/c+rCl/xbZzfUxjfQNUUpVSPoLg/3iitgC/RSBguZFPmQD33Oe0oWkQmnpy
x9/CtzynxhRIjjH+6d2fOuNzuzKIDm9AO6Lvaa8DE6cQ9uYQEJWr8wYBkaOt87XM
HciY05wkysrqjAnv2u/jIPwffcEca+eSVuD9FiHZQ3i6DE7OT9/F/cu8uyXKttzx
9OXNXOw/IwBLOFpN28EQ0rTQG/ky5g==
=qNIp
-----END PGP SIGNATURE-----

--Wrk7U+tg6x4DUmcA--


