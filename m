Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E189E7BDB7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 12:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrxvy-00035a-DI; Mon, 16 Feb 2026 07:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vrxvt-00034t-Jm
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 07:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vrxvr-0004bN-6k
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 07:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771245749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5a81tuM+MAE9ZfJm3QKffXKPyS8F4EexeHB+vBsyPu4=;
 b=QxKFVMic1UwNQIqVE4Z0CIpDDrkRnTH92uXjJbm6CW889juHvQFuvbXdJdeMne9VA48t1g
 pOnYxHlHkv0NB74JjQPAXEcKMxTdLoJKWWaKO3RtoMIilVJawsip+QGq+cvuJuKuy5q0au
 +8LV2+xfv2mJq7PkKpoPGlwc2WbHIMQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-oJAFSlLyNq28xwTE-1pfNA-1; Mon,
 16 Feb 2026 07:42:27 -0500
X-MC-Unique: oJAFSlLyNq28xwTE-1pfNA-1
X-Mimecast-MFC-AGG-ID: oJAFSlLyNq28xwTE-1pfNA_1771245744
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B3801800342; Mon, 16 Feb 2026 12:42:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEE0219560AD; Mon, 16 Feb 2026 12:42:21 +0000 (UTC)
Date: Mon, 16 Feb 2026 07:42:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
Message-ID: <20260216124220.GA391065@fedora>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260119181630.GA834718@fedora>
 <eb9693ae-6aae-4599-8c8c-22268357d2c0@linux.ibm.com>
 <20260203211222.GB449076@fedora>
 <b507e8c4-47c8-44fb-a7fc-6239e029cd56@linux.ibm.com>
 <20260212185321.GA257116@fedora>
 <b338db97-efdc-445f-9e9c-34091425d3d5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZX7okOAnJl77fjUE"
Content-Disposition: inline
In-Reply-To: <b338db97-efdc-445f-9e9c-34091425d3d5@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--ZX7okOAnJl77fjUE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 09:13:29AM -0600, JAEHOON KIM wrote:
> On 2/12/2026 12:53 PM, Stefan Hajnoczi wrote:
> > On Fri, Feb 06, 2026 at 12:50:38AM -0600, JAEHOON KIM wrote:
> > > On 2/3/2026 3:12 PM, Stefan Hajnoczi wrote:
> > > > On Fri, Jan 23, 2026 at 01:15:04PM -0600, JAEHOON KIM wrote:
> > > > > On 1/19/2026 12:16 PM, Stefan Hajnoczi wrote:
> > > > > > On Tue, Jan 13, 2026 at 11:48:21AM -0600, Jaehoon Kim wrote:
> > > > > > > We evaluated the patches on an s390x host with a single guest=
 using 16
> > > > > > > virtio block devices backed by FCP multipath devices in a sep=
arate-disk
> > > > > > > setup, with the I/O scheduler set to 'none' in both host and =
guest.
> > > > > > >=20
> > > > > > > The fio workload included sequential and random read/write wi=
th varying
> > > > > > > numbers of jobs (1,4,8,16) and io_depth of 8. The tests were =
conducted
> > > > > > > with single and dual iothreads, using the newly introduced po=
ll-weight
> > > > > > > parameter to measure their impact on CPU cost and throughput.
> > > > > > >=20
> > > > > > > Compared to the baseline, across four FIO workload patterns (=
sequential
> > > > > > > R/W, random R/W), and averaged over FIO job counts of 1, 4, 8=
, and 16,
> > > > > > > throughput decreased slightly (-3% to -8% for one iothread, -=
2% to -5%
> > > > > > > for two iothreads), while CPU usage on the s390x host dropped
> > > > > > > significantly (-10% to -25% and -7% to -12%, respectively).
> > > > > > Hi Jaehoon,
> > > > > > I would like to run the same fio benchmarks on a local NVMe dri=
ve (<10us
> > > > > > request latency) to see how that type of hardware configuration=
 is
> > > > > > affected. Are the scripts and fio job files available somewhere?
> > > > > >=20
> > > > > > Thanks,
> > > > > > Stefan
> > > > > Thank you for your reply.
> > > > > The fio scripts are not available in a location you can access, b=
ut there is nothing particularly special in the settings.
> > > > > I=E2=80=99m sharing below the methodology and test setup used by =
our performance team.
> > > > >=20
> > > > > Guest Setup
> > > > > ----------------------
> > > > > - 12 vCPUs, 4 GiB memory
> > > > > - 16 virtio disks based on the FCP multipath devices in the host
> > > > >=20
> > > > > FIO test parameters
> > > > > -----------------------
> > > > > - FIO Version: fio-3.33
> > > > > - Filesize: 2G
> > > > > - Blocksize: 8K / 128K
> > > > > - Direct I/O: 1
> > > > > - FIO I/O Engine: libaio
> > > > > - NUMJOB List: 1, 4, 8, 16
> > > > > - IODEPTH: 8
> > > > > - Runtime (s): 150
> > > > >=20
> > > > > Two FIO samples for random read
> > > > > --------------------------------
> > > > > fio --direct=3D1 --name=3Dtest --numjobs=3D16 --filename=3Dbase.0=
=2E0:base.1.0:base.2.0:base.3.0:base.4.0:base.5.0:base.6.0:base.7.0:base.8.=
0:base.9.0:base.10.0:base.11.0:base.12.0:base.13.0:base.14.0:base.15.0 --si=
ze=3D32G  --time_based --runtime=3D4m --readwrite=3Drandread --ioengine=3Dl=
ibaio --iodepth=3D8 --bs=3D8k
> > > > > fio --direct=3D1 --name=3Dtest --numjobs=3D4  --filename=3Dsubw1/=
base.0.0:subw4/base.3.0:subw8/base.7.0:subw12/base.11.0:subw16/base.15.0   =
                                                                     --size=
=3D8G   --time_based --runtime=3D4m --readwrite=3Drandread --ioengine=3Dlib=
aio --iodepth=3D8 --bs=3D8k
> > > > >=20
> > > > >=20
> > > > > additional notes
> > > > > ----------------
> > > > > - Each file is placed on a separate disk device mounted under sub=
w<n> as specified in --filename=3D....
> > > > > - We execute one warmup run, then two measurement runs and calcul=
ate the average
> > > > Hi Jaehoon,
> > > > I ran fio benchmarks on an Intel Optane SSD DC P4800X Series drive =
(<10
> > > > microsecond latency). This is with just 1 drive.
> > > >=20
> > > > The 8 KiB block size results show something similar to what you
> > > > reported: there are IOPS (or throughput) regressions and CPU utiliz=
ation
> > > > improvements.
> > > >=20
> > > > Although the CPU improvements are welcome, I think the default beha=
vior
> > > > should only be changed if the IOPS regressions can be brought below=
 5%.
> > > >=20
> > > > The regressions seem to happen regardless of whether 1 or 2 IOThrea=
ds
> > > > are configured. CPU utilization is different (98% vs 78%) depending=
 on
> > > > the number of IOThreads, so the regressions happen across a range o=
f CPU
> > > > utilizations.
> > > >=20
> > > > The 128 KiB block size results are not interesting because the drive
> > > > already saturates at numjobs=3D1. This is expected since the drive =
cannot
> > > > go much above ~2 GiB/s throughput.
> > > >=20
> > > > You can find the Ansible playbook, libvirt domain XML, fio
> > > > command-lines, and the fio/sar data here:
> > > >=20
> > > > https://gitlab.com/stefanha/virt-playbooks/-/tree/aio-polling-effic=
iency
> > > >=20
> > > > Please let me know if you'd like me to rerun the benchmark with new
> > > > patches or a configuration change.
> > > >=20
> > > > Do you want to have a video call to discuss your work and how to ge=
t the
> > > > patches merged?
> > > >=20
> > > > Host
> > > > ----
> > > > CPU: Intel Xeon Silver 4214 CPU @ 2.20GHz
> > > > RAM: 32 GiB
> > > >=20
> > > > Guest
> > > > -----
> > > > vCPUs: 8
> > > > RAM: 4 GiB
> > > > Disk: 1 virtio-blk aio=3Dnative cache=3Dnone
> > > >=20
> > > > IOPS
> > > > ----
> > > > rw        bs   numjobs iothreads iops   diff
> > > > randread  8k   1       1         163417 -7.8%
> > > > randread  8k   1       2         165041 -2.4%
> > > > randread  8k   4       1         221508 -0.64%
> > > > randread  8k   4       2         251298 0.008%
> > > > randread  8k   8       1         222128 -0.51%
> > > > randread  8k   8       2         249489 -2.6%
> > > > randread  8k   16      1         230535 -0.18%
> > > > randread  8k   16      2         246732 -0.22%
> > > > randread  128k 1       1          17616 -0.11%
> > > > randread  128k 1       2          17678 0.027%
> > > > randread  128k 4       1          17536 -0.27%
> > > > randread  128k 4       2          17610 -0.031%
> > > > randread  128k 8       1          17369 -0.42%
> > > > randread  128k 8       2          17433 -0.071%
> > > > randread  128k 16      1          17215 -0.61%
> > > > randread  128k 16      2          17269 -0.22%
> > > > randwrite 8k   1       1         156597 -3.1%
> > > > randwrite 8k   1       2         157720 -3.8%
> > > > randwrite 8k   4       1         218448 -0.5%
> > > > randwrite 8k   4       2         247075 -5.1%
> > > > randwrite 8k   8       1         220866 -0.75%
> > > > randwrite 8k   8       2         260935 -0.011%
> > > > randwrite 8k   16      1         230913 0.23%
> > > > randwrite 8k   16      2         261125 -0.01%
> > > > randwrite 128k 1       1          16009 0.094%
> > > > randwrite 128k 1       2          16070 0.035%
> > > > randwrite 128k 4       1          16073 -0.62%
> > > > randwrite 128k 4       2          16131 0.059%
> > > > randwrite 128k 8       1          16106 0.092%
> > > > randwrite 128k 8       2          16153 0.048%
> > > > randwrite 128k 16      1          16102 -0.0091%
> > > > randwrite 128k 16      2          16160 0.048%
> > > >=20
> > > > IOThread CPU usage
> > > > ------------------
> > > > iothreads before  after
> > > > 1         98.7    95.81
> > > > 2         78.43   66.13
> > > >=20
> > > > Stefan
> > > Hello Stefan,
> > >=20
> > > Thank you very much for your effort in running these benchmarks.
> > > The results show a pattern very similar to what our performance team
> > > observed.
> > >=20
> > > I fully agree with the 5% threshold for the default behavior.
> > > However, we need an approach that balances the current performance
> > > oriented polling scheme with CPU efficiency.
> > >=20
> > > I found that relying on grow/shrink parameters was too limited to
> > > achieve these results. This is why I've adjusted the process using a
> > > weight-based grow/shrink approach to ensure the polling window remains
> > > robust against jitter. Specifically, it avoids abrupt resets to zero
> > > by implementing a gradual shrink rather than an immediate reset, even
> > > when device latency exceeds the threshold.
> > >=20
> > > As seen in both your results and our team's measurements, this may le=
ad
> > > to a bit of a performance trade-off, but it provides a reasonable
> > > balance for CPU-sensitive environment.
> > >=20
> > > Thank you for suggesting the video call and I am also looking forward=
 to
> > > hearing your thoughts. I'm on US Central Time. Except for Tuesday, I =
can
> > > adjust my schedule to a time that works for you.
> > >=20
> > > Please let me know your preferred time.
> > Is Monday, February 16th at 10:00am CST good for you? If not, please
> > feel free to pick any time on Monday.
> >=20
> > Meeting link: https://meet.jit.si/AioPollingOptimization
> >=20
> > Anyone else interested in this topic is welcome to join.
> >=20
> > Thanks,
> > Stefan
>=20
> Thank you for the invite, Stefan.
> Monday at 10:00 AM CST works well for me.
> I'll make sure to be there and look forward to the discussion. See you th=
en!

Great, talk to you soon!

Stefan

--ZX7okOAnJl77fjUE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmTEKwACgkQnKSrs4Gr
c8hJLAgAmrHNXI1AiPpV4UeL85Ko2poA0d2IZqQNBnPF2UgGMTfbRMO0Vs2f3BTc
fm6QTgyU6W8GUvzSjfALhXxJXQ+J0lrjNNljcrZ9aW2Vw+M3VNQw87GN2qiiWAEg
Xx+Gr2RBCgUpqsYHOXnt5NS1gkhogo77mBjM7nAURPM9k//jVUIih8krkTgYNmOr
DvJWJ3wdESqH/K94kerLw82SFmpbSctzf3TXamYnGgzePEOlkeM2YG7WReOEew6s
fBM4xAr3KA/OWlRfW4qADqElgiTBclSvHTTrQa2Wau96XmHYzWMjuTo+12gigQEt
Tu3ZdOYRUdQAkIf/sKN3GTn9kAtwNQ==
=VNLc
-----END PGP SIGNATURE-----

--ZX7okOAnJl77fjUE--


