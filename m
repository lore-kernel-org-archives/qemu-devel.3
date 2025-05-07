Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6202BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjQT-0006oS-Ju; Wed, 07 May 2025 14:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCjQR-0006o7-E6
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCjQP-00027x-1i
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746642199;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0MJ1fACUa8aT/myQKyr2llpV7mLrlFzTPMPx1cAk0U=;
 b=fZM9NINf2/QZPHfo4NLxvKY3NW66fIl+1wxulLOizYLCY/+zO0b6GJJ4bsGaG9NoS/nA/9
 o5QXxVj5HGKgYo60nuhWwONwYB4dMZH5bJDG4KXkWvdPuB0XmqgYh2i0oNkP/hD2LFd58v
 PDl0xaunArjY69gCsvTmoGPuWB8hL7s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-9EmSthmuNg62A3tqjVqTdA-1; Wed,
 07 May 2025 14:23:16 -0400
X-MC-Unique: 9EmSthmuNg62A3tqjVqTdA-1
X-Mimecast-MFC-AGG-ID: 9EmSthmuNg62A3tqjVqTdA_1746642195
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3E70180056F; Wed,  7 May 2025 18:23:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EAC430001A1; Wed,  7 May 2025 18:23:12 +0000 (UTC)
Date: Wed, 7 May 2025 19:23:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Jones <rjones@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/2] io: Increase unix socket buffers size on macOS
Message-ID: <aBulDPx3h02280i2@redhat.com>
References: <20250427165029.9072-1-nirsof@gmail.com>
 <20250427165029.9072-2-nirsof@gmail.com>
 <aBuMQSEm9f8JsdoQ@redhat.com>
 <FAF66BF6-176E-43A8-B097-85960D81ADCE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FAF66BF6-176E-43A8-B097-85960D81ADCE@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 07, 2025 at 08:17:19PM +0300, Nir Soffer wrote:
> 
> 
> > On 7 May 2025, at 19:37, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > On Sun, Apr 27, 2025 at 07:50:28PM +0300, Nir Soffer wrote:
> >> On macOS we need to increase unix stream socket buffers size on the
> >> client and server to get good performance. We set socket buffers on
> >> macOS after connecting or accepting a client connection.  For unix
> >> datagram socket we need different configuration that can be done later.
> >> 
> >> Testing shows that setting socket receive buffer size (SO_RCVBUF) has no
> >> effect on performance, so we set only the send buffer size (SO_SNDBUF).
> >> It seems to work like Linux but not documented.
> >> 
> >> Testing shows that optimal buffer size is 512k to 4 MiB, depending on
> >> the test case. The difference is very small, so I chose 2 MiB.
> >> 
> >> I tested reading from qemu-nbd and writing to qemu-nbd with qemu-img and
> >> computing a blkhash with nbdcopy and blksum.
> >> 
> >> To focus on NBD communication and get less noisy results, I tested
> >> reading and writing to null-co driver. I added a read-pattern option to
> >> the null-co driver to return data full of 0xff:
> >> 
> >>    NULL="json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '10g', 'read-pattern': -1}}"
> >> 
> >> For testing buffer size I added an environment variable for setting the
> >> socket buffer size.
> >> 
> >> Read from qemu-nbd via qemu-img convert. In this test buffer size of 2m
> >> is optimal (12.6 times faster).
> >> 
> >>    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
> >>    qemu-img convert -f raw -O raw -W -n "nbd+unix:///?socket=/tmp/nbd.sock" "$NULL"
> >> 
> >> | buffer size | time    | user    | system  |
> >> |-------------|---------|---------|---------|
> >> |     default |  13.361 |   2.653 |   5.702 |
> >> |       65536 |   2.283 |   0.204 |   1.318 |
> >> |      131072 |   1.673 |   0.062 |   1.008 |
> >> |      262144 |   1.592 |   0.053 |   0.952 |
> >> |      524288 |   1.496 |   0.049 |   0.887 |
> >> |     1048576 |   1.234 |   0.047 |   0.738 |
> >> |     2097152 |   1.060 |   0.080 |   0.602 |
> >> |     4194304 |   1.061 |   0.076 |   0.604 |
> >> 
> >> Write to qemu-nbd with qemu-img convert. In this test buffer size of 2m
> >> is optimal (9.2 times faster).
> >> 
> >>    qemu-nbd -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
> >>    qemu-img convert -f raw -O raw -W -n "$NULL" "nbd+unix:///?socket=/tmp/nbd.sock"
> >> 
> >> | buffer size | time    | user    | system  |
> >> |-------------|---------|---------|---------|
> >> |     default |   8.063 |   2.522 |   4.184 |
> >> |       65536 |   1.472 |   0.430 |   0.867 |
> >> |      131072 |   1.071 |   0.297 |   0.654 |
> >> |      262144 |   1.012 |   0.239 |   0.587 |
> >> |      524288 |   0.970 |   0.201 |   0.514 |
> >> |     1048576 |   0.895 |   0.184 |   0.454 |
> >> |     2097152 |   0.877 |   0.174 |   0.440 |
> >> |     4194304 |   0.944 |   0.231 |   0.535 |
> >> 
> >> Compute a blkhash with nbdcopy, using 4 NBD connections and 256k request
> >> size. In this test buffer size of 4m is optimal (5.1 times faster).
> >> 
> >>    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
> >>    nbdcopy --blkhash "nbd+unix:///?socket=/tmp/nbd.sock" null:
> >> 
> >> | buffer size | time    | user    | system  |
> >> |-------------|---------|---------|---------|
> >> |     default |   8.624 |   5.727 |   6.507 |
> >> |       65536 |   2.563 |   4.760 |   2.498 |
> >> |      131072 |   1.903 |   4.559 |   2.093 |
> >> |      262144 |   1.759 |   4.513 |   1.935 |
> >> |      524288 |   1.729 |   4.489 |   1.924 |
> >> |     1048576 |   1.696 |   4.479 |   1.884 |
> >> |     2097152 |   1.710 |   4.480 |   1.763 |
> >> |     4194304 |   1.687 |   4.479 |   1.712 |
> >> 
> >> Compute a blkhash with blksum, using 1 NBD connection and 256k read
> >> size. In this test buffer size of 512k is optimal (10.3 times faster).
> >> 
> >>    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
> >>    blksum "nbd+unix:///?socket=/tmp/nbd.sock"
> >> 
> >> | buffer size | time    | user    | system  |
> >> |-------------|---------|---------|---------|
> >> |     default |  13.085 |   5.664 |   6.461 |
> >> |       65536 |   3.299 |   5.106 |   2.515 |
> >> |      131072 |   2.396 |   4.989 |   2.069 |
> >> |      262144 |   1.607 |   4.724 |   1.555 |
> >> |      524288 |   1.271 |   4.528 |   1.224 |
> >> |     1048576 |   1.294 |   4.565 |   1.333 |
> >> |     2097152 |   1.299 |   4.569 |   1.344 |
> >> |     4194304 |   1.291 |   4.559 |   1.327 |
> >> 
> >> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> >> ---
> >> io/channel-socket.c | 32 ++++++++++++++++++++++++++++++++
> >> 1 file changed, 32 insertions(+)
> >> 
> >> diff --git a/io/channel-socket.c b/io/channel-socket.c
> >> index 608bcf066e..06901ab694 100644
> >> --- a/io/channel-socket.c
> >> +++ b/io/channel-socket.c
> >> @@ -21,6 +21,7 @@
> >> #include "qapi/error.h"
> >> #include "qapi/qapi-visit-sockets.h"
> >> #include "qemu/module.h"
> >> +#include "qemu/units.h"
> >> #include "io/channel-socket.h"
> >> #include "io/channel-util.h"
> >> #include "io/channel-watch.h"
> >> @@ -37,6 +38,33 @@
> >> 
> >> #define SOCKET_MAX_FDS 16
> >> 
> >> +/*
> >> + * Testing shows that 2m send buffer gives best throuput and lowest cpu usage.
> >> + * Changing the receive buffer size has no effect on performance.
> >> + */
> >> +#ifdef __APPLE__
> >> +#define UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE (2 * MiB)
> >> +#endif /* __APPLE__ */
> >> +
> >> +static void qio_channel_socket_set_buffers(QIOChannelSocket *ioc)
> >> +{
> >> +    if (ioc->localAddr.ss_family == AF_UNIX) {
> >> +        int type;
> >> +        socklen_t type_len = sizeof(type);
> >> +
> >> +        if (getsockopt(ioc->fd, SOL_SOCKET, SO_TYPE, &type, &type_len) == -1) {
> >> +            return;
> >> +        }
> >> +
> >> +#ifdef UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE
> >> +        if (type == SOCK_STREAM) {
> >> +            const int value = UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE;
> >> +            setsockopt(ioc->fd, SOL_SOCKET, SO_SNDBUF, &value, sizeof(value));
> >> +        }
> >> +#endif /* UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE */
> >> +    }
> >> +}
> > 
> > While I'm not doubting your benchmark results, I'm a little uneasy about
> > setting this unconditionally for *all* UNIX sockets QEMU creates. The
> > benchmarks show NBD benefits from this, but I'm not convinced that all
> > the other scenarios QEMU creates UNIX sockets for justify it.
> > 
> > On Linux, whatever value you set with SO_SNDBUF appears to get doubled
> > internally by the kernel.
> > 
> > IOW, this is adding 4 MB fixed overhead for every UNIX socket that
> > QEMU creates. It doesn't take many UNIX sockets in QEMU for that to
> > become a significant amount of extra memory overhead on a host.
> > 
> > I'm thinking we might be better with a helper
> > 
> >  qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc, size_t size)
> > 
> > that we call from the NBD code, to limit the impact. Also I think this
> > helper ought not to filter on AF_UNIX - the caller can see the socket
> > type via qio_channel_socket_get_local_address if it does not already
> > have a record of the address, and selectively set the buffer size.
> 
> So you suggest to move also UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE to nbd?
> 
> If we use this only for nbd this is fine, but once we add another caller we will
> to duplicate the code selecting the right size for the OS. But I guess we can 
> reconsider this when have this problem.

Yeah, lets worry about that aspect another day and focus on NBD.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


