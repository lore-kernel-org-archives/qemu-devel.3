Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67B310F287C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GfH-0001cp-Cl; Fri, 27 Mar 2026 19:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GfF-0001cQ-N6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:32:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GfE-0007lX-2w
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:32:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so28186725e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774654346; x=1775259146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SdlDVxlcbRhjw2pJuGzVZI2mDTbd6L4tJ1o5D1L64n8=;
 b=FPYg4B4gOk5c/26yXQHQYT65ZlVNoSvzdWXw03GnohECLxOuAtn+fQqkgVHthiCSiN
 sHQOSaHMvwAUERI31NGgXGeVSw5tWggo+BI9aHNDtHv+GaRlRgUA6PS8reiBra/AShwL
 9SrC5CQOWvYKEqpud7ZlvyeJdFOgtNOP9VqfMhmpF/BzDBlFRNx3iNp+CZgbJyqiF0KF
 ATwqAkuPkYqi6YxYestenqVFHgh47+JsEB+vG0y+xrqCSX98nKZCIV25Iw+5GYMuf4bV
 ptdc7dMDADcN1X/1SyDk20etvsBwUyLAoxeN18cODrwY+S5y/Q6NEhRcQLs2qOpmHtnm
 OffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774654346; x=1775259146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdlDVxlcbRhjw2pJuGzVZI2mDTbd6L4tJ1o5D1L64n8=;
 b=EUVjKm/UvicinBBvCVhpurDN4dzFeGwQdoTDyqAahXsfgQsg2t/EWqTgH2PN/mIGhN
 r0l3jauUE24ODBvDZdm8LQn6x+2EHaJoOktAA9PqC6bApVssXdTGpV1BrR8+gzLQzXc9
 psCMUMjPny4oDUblaQ1rEUAfwoeGAbFDMUlFHEXs1u1OhfvrlMYhsct4iJOdLRFJaM/q
 ijPUvqTfFFY1eA6GM4xlkQPeSEG+6sV8yjeospJKkjezW1TXrsXyDCHEEk6h4XZC/gPN
 psMT4weHeo+co/WB4ovWZwfhCJxWumYyAjLZp4iD3I/FEoGqrHW9N5ikU1ECOUOHM02D
 165w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTIbjqFbVzRVPlBNip8xM1j2GFATGP3JFm/pYBsFVljYW0cu6P215wx89C9OLqRjZddSW76/fn6tUs@nongnu.org
X-Gm-Message-State: AOJu0YxUwdG+0F3kpDXO2Hea1bRUpbWDavwue4iMHN+vF+tgv5ho7lPR
 f8KqUQ/sNx4FPNeP9ZrwLaR+dKlSNHe7zGilTe2x3nMJRkBMbXS8YfUR5D5o2Ub7Of0=
X-Gm-Gg: ATEYQzzbasUtNZgPPAvlXG/HJ416bMxwQCjm3EbrhOcz1gB6HGnZsRTjjTT8jbr6CSp
 QxRCnS46RntF2fjXlSXPCzxdidmJhSDlU3u12Crsl15EbcDV+0FCGcdD8Owj0w8CWr/rooolqqq
 Fy4pvn+si7ubk7gv31OZpciG765/AqOUCCq5PQWsETcuInXCZ4LsKLXoqOCM3X6pSvNob+VphJU
 WAdJwcPz/ZzVg9ri+EqxW12KDnN9MNZdtg5d7TF465mTZ0iDYAugBLK8Fip+9LwXdecvYeqEkqN
 TPu1+sfI+qsmewUsSzAHErO6HprZT0r1dG/zJ9PKvpAxxuoGgFseKqWP6iBgOHP4ZGfU7LBk6gY
 /E7vft/A88PmJjM7j5znIE+V/WDymDwoptLuMqDWLabs1BTIoDDUU6M7wWLYucvj5QCl4v8RetP
 6jT47HHv9EM0fP3O2uv5/SjgHBQUnt77+gLtDbNPW/4c/24WnPTjgBwamyX1Otwg==
X-Received: by 2002:a05:600c:3513:b0:486:fb5c:3b20 with SMTP id
 5b1f17b1804b1-48727f23fccmr65102635e9.13.1774654345999; 
 Fri, 27 Mar 2026 16:32:25 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48725ebe9dfsm35832795e9.4.2026.03.27.16.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:32:24 -0700 (PDT)
Message-ID: <ca8ca985-d780-4c85-a91b-657560f47d2b@linaro.org>
Date: Sat, 28 Mar 2026 00:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] ncr710, lsi: use same enums for command_complete
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20260327212547.460420-1-pbonzini@redhat.com>
 <20260327212547.460420-7-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327212547.460420-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 27/3/26 22:25, Paolo Bonzini wrote:
> The ncr710 and lsi53c895a HBAs share some of the logic, also make
> them use the same enum for the command_complete variable.  Change
> the names for ncr710 to something that is more representative,
> for example NCR710_CMD_DATA_READY might also indicate that the
> device is ready to *receive* data, not just that it has data
> ready to send.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/ncr53c710.h  |  4 ++--
>   hw/scsi/lsi53c895a.c | 16 +++++++++++-----
>   hw/scsi/ncr53c710.c  | 10 +++++-----
>   3 files changed, 18 insertions(+), 12 deletions(-)


> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 54123f77579..6b0c97d98e3 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -209,6 +209,12 @@ enum {
>       LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
>   };
>   
> +typedef enum {
> +    LSI_CMD_SENT, /* command is running */
> +    LSI_CMD_READY, /* one round of data transfer completed */
> +    LSI_CMD_COMPLETE, /* command completed */
> +} LSICommandState;
> +
>   enum {
>       LSI_MSG_ACTION_COMMAND = 0,
>       LSI_MSG_ACTION_DISCONNECT = 1,
> @@ -238,7 +244,7 @@ struct LSIState {
>       int current_lun;
>       /* The tag is a combination of the device ID and the SCSI tag.  */
>       uint32_t select_tag;
> -    int command_complete;
> +    LSICommandState command_complete;
>       QTAILQ_HEAD(, lsi_request) queue;
>       lsi_request *current;
>   
> @@ -815,7 +821,7 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
>       out = (s->sstat1 & PHASE_MASK) == PHASE_DO;
>       trace_lsi_command_complete(req->status);
>       s->status = req->status;
> -    s->command_complete = 2;
> +    s->command_complete = LSI_CMD_COMPLETE;
>       if (s->waiting && s->dbc != 0) {
>           /* Raise phase mismatch for short transfers.  */
>           stop = lsi_bad_phase(s, out, PHASE_ST);
> @@ -854,7 +860,7 @@ static void lsi_transfer_data(SCSIRequest *req, uint32_t len)
>       /* host adapter (re)connected */
>       trace_lsi_transfer_data(req->tag, len);
>       s->current->dma_len = len;
> -    s->command_complete = 1;
> +    s->command_complete = LSI_CMD_READY;
>       if (s->waiting) {
>           if (s->waiting == LSI_WAIT_RESELECT || s->dbc == 0) {
>               lsi_resume_script(s);
> @@ -876,7 +882,7 @@ static void lsi_do_command(LSIState *s)
>           s->dbc = 16;
>       pci_dma_read(PCI_DEVICE(s), s->dnad, buf, s->dbc);
>       s->sfbr = buf[0];
> -    s->command_complete = 0;
> +    s->command_complete = LSI_CMD_PENDING;

Where is LSI_CMD_PENDING defined?

../../hw/scsi/lsi53c895a.c:885:27: error: use of undeclared identifier 
'LSI_CMD_PENDING'
   885 |     s->command_complete = LSI_CMD_PENDING;
       |                           ^
../../hw/scsi/lsi53c895a.c:909:32: error: use of undeclared identifier 
'LSI_CMD_PENDING'
   909 |     if (s->command_complete == LSI_CMD_PENDING) {
       |                                ^

>   
>       id = (s->select_tag >> 8) & 0xf;
>       dev = scsi_device_find(&s->bus, 0, id, s->current_lun);
> @@ -900,7 +906,7 @@ static void lsi_do_command(LSIState *s)
>           }
>           scsi_req_continue(s->current->req);
>       }
> -    if (!s->command_complete) {
> +    if (s->command_complete == LSI_CMD_PENDING) {
>           if (n) {
>               /* Command did not complete immediately so disconnect.  */
>               lsi_add_msg_byte(s, 2); /* SAVE DATA POINTER */

