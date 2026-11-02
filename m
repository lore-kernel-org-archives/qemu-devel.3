Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605FC606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=BCL/tTFD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsJV-00021t-Gk; Mon, 02 Nov 2026 08:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xNsJO-000215-T7; Mon, 02 Nov 2026 08:43:00 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xNsJL-0002oS-4v; Mon, 02 Nov 2026 08:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793626963; bh=gNmzncyRRVIjyr2E1DuEnhGKsq1rYFcerQr9+HfNpmc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BCL/tTFDoJUa1+HFHGqdmEmWgZnkDr1nNWhjFW0QlMxCdL8mEUmA9E0XKYJu2BmN3
 9Jkk590P++uvBtt1x+oWHO9Abbk22ZB1z0EMLA1vJ9NtcCKy0S3NoTnx8rXovRhud4
 AOhS2cdf08GsC/cJxxu6Maci9XA2wfjRZU4yGjbp18pyZzWEHXyY92CtkiLLTTZzQz
 UWiSH7lTHOUtUy5UpvQcnntVTGZw16IyKQ/F15Ewa4FivGDVXfid/5IWYTp1MvCU79
 gY6jAdHWt6nk1qTpJBjM8Mv4aSndsKrcY0bhnn04/tu5fMEKgK7jnxmheJy+sdJ1wg
 VRriXIcr2Zwdg==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 5AEEC1E3351;
 Mon, 02 Nov 2026 16:42:43 +0300 (MSK)
Message-ID: <92da7631-c19b-43e0-9122-618f98cc102c@tls.msk.ru>
Date: Mon, 2 Nov 2026 16:42:42 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/12] hw/ufs: Check the PRDT size against the transfer
 length of the CDB
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 daejun7.park@samsung.com, stanleyjhu@google.com, dridiha98@gmail.com,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, qemu-stable@nongnu.org
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
 <f9e0f4d949a0cec465e5f40ce8721b49b7850371.1793347487.git.jeuk20.kim@samsung.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <f9e0f4d949a0cec465e5f40ce8721b49b7850371.1793347487.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30.10.2026 11:14, Jeuk Kim wrote:
> From: Daejun Park <daejun7.park@samsung.com>
> 
> scsi-hd moves as many bytes as the SG list of a request holds, and
> ufs-lu builds that list from the whole PRDT. When the PRDT is larger
> than the transfer length in the CDB, a WRITE writes more blocks than
> the CDB names and a READ reads more. A one-block WRITE(10) at LBA 0
> with an 8 KiB PRDT also wrote LBA 1, and its response reported no
> residual. A UFS device transfers what the CDB asks for and reports the
> rest of the Expected Data Transfer Length as a residual.
> 
> The commands that scsi-hd emulates had their residual computed against
> the PRDT too: an INQUIRY with an allocation length of 36, a 4 KiB PRDT
> and an Expected Data Transfer Length of 4096 reported an overflow of
> 4294959176 bytes. It now reports an underflow of 4060.
> 
> When the PRDT is smaller than the transfer length, scsi-hd moved what it
> holds and the request completed without an error, for example a
> two-block WRITE(10) with a 4 KiB PRDT. Such a request now fails with OCS
> MISMATCH DATA BUFFER SIZE, as one without a PRDT does. As in
> virtio-scsi, the PRDT is compared with the transfer length of the CDB,
> which for commands that return data is the allocation length, and before
> scsi-hd checks the CDB.
> 
> The new ufs_fit_data_buffer() in ufs.c, where the SG list is built from
> the PRDT, cuts a longer list and reports a shorter one; ufs-lu passes it
> the transfer length that scsi_req_new() parsed. The HID qtest wrote
> eight blocks from a one-block buffer, so give it eight blocks. The new
> long-prdt and short-prdt qtests failed before this change.
> 
> Fixes: 2a8b36a4967d ("hw/ufs: Support for UFS logical unit")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> Reviewed-by: Stanley Jhu <stanleyjhu@google.com>
> Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>   hw/ufs/lu.c            |  20 +++---
>   hw/ufs/trace-events    |   1 +
>   hw/ufs/ufs.c           |  35 ++++++++++
>   hw/ufs/ufs.h           |   1 +
>   tests/qtest/ufs-test.c | 141 ++++++++++++++++++++++++++++++++++++++++-
>   5 files changed, 189 insertions(+), 9 deletions(-)

Hi!

This patch is tagged for-stable.  When trying to cherry-pick it to 10.0.x
series, I notieced the change to ufs-test.c does not apply, this one:

> --- a/tests/qtest/ufs-test.c
> +++ b/tests/qtest/ufs-test.c
> @@ -1577,7 +1713,8 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
>           /* WRITE(10) to LBA 0, transfer length 8 sectors = 1 fragment */
>           WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00
>       };
> -    uint8_t write_buf[4096];
> +    /* The PRDT must hold the eight blocks that the WRITE(10) moves */
> +    uint8_t write_buf[8 * 4096];
>       uint8_t read_buf[4096];
>       int i;
>   

This is because 10.0.x has no UFS HID support.

So, it is not the test itself which does not apply, but modifying parameters
for another test, which, apparently, triggers this PRDT one.

Without knowing all the details about all hardware specifics involved,
I can't say for sure what's going on here.  How the two (HID & this
PRTD change) are related and what should be the test for 10.0.x ?

Thanks!

/mjt

