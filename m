Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B03DE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 03:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXAhd-0008WE-ST; Sun, 12 Jan 2025 22:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tXAhb-0008Vg-VI
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 22:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tXAha-00030G-Co
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 22:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736737277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJAedF2T7kxUO0pdpN0+pQQSACB+LDRt6k5x4lxfKpY=;
 b=clTJCaNHvkg3DltB0HHuJosEpfJltMVUqGwiwDYU14RAPGDrmSGi4Ijsz3+hc//jN//Bhm
 /220YDsUPqwV5h3QsvsoZLBUyGUTN3PKSrAGMkje2V90JxJKtJKZPS4qaDSLIAv4AeI3Ox
 etNODI2xKpumGPjsxxcL6pnEthIXhow=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-qK60hlwLPPieecsI1R4Bqg-1; Sun, 12 Jan 2025 22:01:15 -0500
X-MC-Unique: qK60hlwLPPieecsI1R4Bqg-1
X-Mimecast-MFC-AGG-ID: qK60hlwLPPieecsI1R4Bqg
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef9204f898so6530576a91.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 19:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736737273; x=1737342073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJAedF2T7kxUO0pdpN0+pQQSACB+LDRt6k5x4lxfKpY=;
 b=o7+7sUJ1VPyc/t5b1CPZZxEDh0RUJz8ccTwTmUybzvX5UGhzqIvcwXaJq7bR9jB3B3
 0nZ9Gz75h/wBDM6BoqcRv9LtLd/fiZFtKgYFogztUWVNh3VZ55KXUmRBwVjNwuN6IXEK
 flZIZYUOAWNbALT7Wuxk/g2VUVd6YF6NkKBgbGEsSh3wTX4pZjdcuiYQuxSFrJYDZGAL
 69R+Jv+bkj8x19cGsNvCIUD8S2nDYfJ9N7E2fAGxf16d+W4w5r7j25n4HeynI4wdAAOs
 CmHXIGHmH3GJ/qHe50JDNAvUXIFVF59ebLWpIOdOK0eK32rXs3Df8Vs+lCY2nmn2r97N
 fvvg==
X-Gm-Message-State: AOJu0YwnvudvX22jSjJbhANVT4pldIzlHeLOTGC8MlY6mjUGXkTPwrbA
 aETUJ0Cvy1hzPLgYuPs78zaC9pzdeeGgGxJZmBH1MpVbGpVZjd7rQ3azj2Kk8cyIr+2AezY2fU3
 EKhV5jlEmyN5Vqg+IDViJBwdQv+S22eUCvQQxQHGmiPPTRw5ninlUH1loOKNcC3uMtXSwM+biYS
 G0P1oI6FOHGc9NO6JutCooOljxqBYbJIQ/FxAIAg==
X-Gm-Gg: ASbGnctbqPEcNZgdvrtjdwPnqOoArEpYg5rCD/RfYYZn4/H1NJB/eCLQowplXnMRhw7
 lhr3dfnpZs3goN0aY6MQyb66puyseNn4B7+94G/o=
X-Received: by 2002:a17:90b:5241:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-2f548f6a009mr31809279a91.17.1736737273329; 
 Sun, 12 Jan 2025 19:01:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxgk+2cVRcmNtOuWZBA+qSfzstXIRXCq0E8H4ScUAwjniHS/bxYHw3OTIIDvEicvkqD5RYFQA1WUapG5sprkE=
X-Received: by 2002:a17:90b:5241:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-2f548f6a009mr31809241a91.17.1736737272954; Sun, 12 Jan 2025
 19:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20240428-iov-v1-0-7b2dd601d80b@daynix.com>
 <20240428-iov-v1-1-7b2dd601d80b@daynix.com>
 <07258bb4-bc8f-4b21-a662-402d3164b68a@linaro.org>
 <2cdcba63-00dd-4580-8a84-19f342ccb9c5@daynix.com>
In-Reply-To: <2cdcba63-00dd-4580-8a84-19f342ccb9c5@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jan 2025 11:01:00 +0800
X-Gm-Features: AbW1kvZWrjm44PJt8qumfnrmobpiMQ4Gc5jqOwJEvCHbFgiDh1PcD6DfeElac5k
Message-ID: <CACGkMEsUxNx3bec2NKm8Edp4S-A4hbF-RK1SbY45anbwe3pvRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] util/iov: Do not assert offset is in iov
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jan 11, 2025 at 1:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Jason, can you pull this series?

Queued.

Thanks

>
> Regards,
> Akihiko Odaki
>
> On 2024/05/08 23:51, Philippe Mathieu-Daud=C3=A9 wrote:
> > ping?
> >
> > On 28/4/24 13:11, Akihiko Odaki wrote:
> >> iov_from_buf(), iov_to_buf(), iov_memset(), and iov_copy() asserts
> >> that the given offset fits in the iov while tolerating the specified
> >> number of bytes to operate with to be greater than the size of iov.
> >> This is inconsistent so remove the assertions.
> >>
> >> Asserting the offset fits in the iov makes sense if it is expected tha=
t
> >> there are other operations that process the content before the offset
> >> and the content is processed in order. Under this expectation, the
> >> offset should point to the end of bytes that are previously processed
> >> and fit in the iov. However, this expectation depends on the details o=
f
> >> the caller, and did not hold true at least one case and required code =
to
> >> check iov_size(), which is added with commit 83ddb3dbba2e
> >> ("hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()").
> >>
> >> Adding such a check is inefficient and error-prone. These functions
> >> already tolerate the specified number of bytes to operate with to be
> >> greater than the size of iov to avoid such checks so remove the
> >> assertions to tolerate invalid offset as well. They return the number =
of
> >> bytes they operated with so their callers can still check the returned
> >> value to ensure there are sufficient space at the given offset.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   include/qemu/iov.h | 5 +++--
> >>   util/iov.c         | 5 -----
> >>   2 files changed, 3 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> >> index 63a1c01965d1..33548058d2ee 100644
> >> --- a/include/qemu/iov.h
> >> +++ b/include/qemu/iov.h
> >> @@ -30,7 +30,7 @@ size_t iov_size(const struct iovec *iov, const
> >> unsigned int iov_cnt);
> >>    * only part of data will be copied, up to the end of the iovec.
> >>    * Number of bytes actually copied will be returned, which is
> >>    *  min(bytes, iov_size(iov)-offset)
> >> - * `Offset' must point to the inside of iovec.
> >> + * Returns 0 when `offset' points to the outside of iovec.
> >>    */
> >>   size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_c=
nt,
> >>                            size_t offset, const void *buf, size_t byte=
s);
> >> @@ -66,11 +66,12 @@ iov_to_buf(const struct iovec *iov, const unsigned
> >> int iov_cnt,
> >>   /**
> >>    * Set data bytes pointed out by iovec `iov' of size `iov_cnt'
> >> elements,
> >>    * starting at byte offset `start', to value `fillc', repeating it
> >> - * `bytes' number of times.  `Offset' must point to the inside of iov=
ec.
> >> + * `bytes' number of times.
> >>    * If `bytes' is large enough, only last bytes portion of iovec,
> >>    * up to the end of it, will be filled with the specified value.
> >>    * Function return actual number of bytes processed, which is
> >>    * min(size, iov_size(iov) - offset).
> >> + * Returns 0 when `offset' points to the outside of iovec.
> >>    */
> >>   size_t iov_memset(const struct iovec *iov, const unsigned int iov_cn=
t,
> >>                     size_t offset, int fillc, size_t bytes);
> >> diff --git a/util/iov.c b/util/iov.c
> >> index 7e73948f5e3d..a523b406b7f8 100644
> >> --- a/util/iov.c
> >> +++ b/util/iov.c
> >> @@ -36,7 +36,6 @@ size_t iov_from_buf_full(const struct iovec *iov,
> >> unsigned int iov_cnt,
> >>               offset -=3D iov[i].iov_len;
> >>           }
> >>       }
> >> -    assert(offset =3D=3D 0);
> >>       return done;
> >>   }
> >> @@ -55,7 +54,6 @@ size_t iov_to_buf_full(const struct iovec *iov,
> >> const unsigned int iov_cnt,
> >>               offset -=3D iov[i].iov_len;
> >>           }
> >>       }
> >> -    assert(offset =3D=3D 0);
> >>       return done;
> >>   }
> >> @@ -74,7 +72,6 @@ size_t iov_memset(const struct iovec *iov, const
> >> unsigned int iov_cnt,
> >>               offset -=3D iov[i].iov_len;
> >>           }
> >>       }
> >> -    assert(offset =3D=3D 0);
> >>       return done;
> >>   }
> >> @@ -266,7 +263,6 @@ unsigned iov_copy(struct iovec *dst_iov, unsigned
> >> int dst_iov_cnt,
> >>           bytes -=3D len;
> >>           offset =3D 0;
> >>       }
> >> -    assert(offset =3D=3D 0);
> >>       return j;
> >>   }
> >> @@ -337,7 +333,6 @@ size_t qemu_iovec_concat_iov(QEMUIOVector *dst,
> >>               soffset -=3D src_iov[i].iov_len;
> >>           }
> >>       }
> >> -    assert(soffset =3D=3D 0); /* offset beyond end of src */
> >>       return done;
> >>   }
> >>
>


