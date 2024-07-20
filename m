Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BDAC3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 22:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVIJ3-0003c7-W8; Sat, 20 Jul 2024 18:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sVIJ2-0003Zn-8W
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 18:11:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sVIJ0-0007LI-J3
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 18:11:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266edcc54cso87405e9.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721513512; x=1722118312; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FDH9b/hMRvMUcJMBkMcovYtJEAbv1WVdTz2/dbvxC1k=;
 b=HCP+GI+GgEqzqlfejutTJe2nHrOzSz4/6BV65l0WroIe2T4HBgr0wgcaLDXlOFgZuy
 eTVRfRn0ykqOtZjl4IG1s/qNpVmRx8MZEfn1ugzL4SqHGk2269se7y5FQeOp0m8EWazn
 mFhwIiOOZFx2sc7jP/hmmFuh2nOq1DAKt417gr35DBzWe1YJQShvAOnkW+zEE0b9q8dC
 IF5Ejyq84CzgxZB0r+ci0INcXDx+utIekCIZIoEoU6XjhqJe/QnEY8lknyWTJmtDhgqK
 XZRoFfjWIKniHf7LbjU9s66KATnKl2MdRP7DVP125BO52oKKn1W4WfDqoH7AlNy4dl2R
 mG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721513512; x=1722118312;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FDH9b/hMRvMUcJMBkMcovYtJEAbv1WVdTz2/dbvxC1k=;
 b=BY3I1sxAJbXZGvDJ4yN0QKupBz7t1mary6pT6UMpFmpJZ9tbeXEN1cHzJHkIAEloRA
 xM+2OZb6Zb/XQ4Mev5MIan3QZp4Jyq/sB0Mo8jVNnikR8WauvkxPxh2Xe0W8vlIcmr7G
 /j7w1HKaftIUsO33oZ8xDdmq2N1H1wP7kzd6gPnuN6oI7x+D+S++pk9alwtXwA9m6n35
 KXQDw3YSKpa3yWfb+JJclZNCNuyOKMOusQ7ZkgGQq5I3zzNMePXCqqPDvXJm5/pk28eh
 uLGQr1YRF2m/rpIll9v8YmqJZJwX8c6moIB8cBoeLFBn6Twk2zi9BO0iDXGSD2QNSSIZ
 radw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpaopDQy8m469roG2EA0DIiXgEZM6TqWsjCp/AcienVg17yK+KZMw03rjExHFZ/Y9EPP755GeRSslOJ8eN7OJwkUMsAjU=
X-Gm-Message-State: AOJu0Yw2pJum+4LIuG6NJ9cDvW/T1hWdPniAZUqExtKgO7pwrXX7+dyU
 wG5kFXz+4EU16gKMuYusF2jrFryffhVzvdaSBMO6vSPGseNPV4Kh+8tPd39mIg==
X-Google-Smtp-Source: AGHT+IFzrZC0RbZzhipr9RyQZLh69/YXpKDOqNrWXbGdRhb9dEzhJG87B3tL4aEpSQKGpCN6Iy+84A==
X-Received: by 2002:a05:600c:1d0a:b0:421:7caf:eb69 with SMTP id
 5b1f17b1804b1-427dbb48583mr1086455e9.4.1721513511668; 
 Sat, 20 Jul 2024 15:11:51 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878695a52sm4670208f8f.64.2024.07.20.15.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 15:11:51 -0700 (PDT)
Date: Sat, 20 Jul 2024 22:11:47 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Julien Grall <julien@xen.org>, eric.auger@redhat.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org,
 maz@kernel.org, nicolinc@nvidia.com, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v5 00/18] SMMUv3 nested translation support
Message-ID: <Zpw2I2ATUqDt19qv@google.com>
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240717150931.GA3988597@myrica>
 <1e7e750b-61bd-4822-8742-124bdf66a7c4@redhat.com>
 <5684927d-d890-42be-841c-ece681502503@xen.org>
 <a0ee8ba3-174f-4d00-807f-31584cba42d4@xen.org>
 <CAFEAcA8T3Yrj_R-B2oUW_Uu3u5HZs4RY1P+A7zF+8xWJnmtpQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8T3Yrj_R-B2oUW_Uu3u5HZs4RY1P+A7zF+8xWJnmtpQA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=smostafa@google.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Peter,

On Fri, Jul 19, 2024 at 04:57:18PM +0100, Peter Maydell wrote:
> On Fri, 19 Jul 2024 at 16:36, Julien Grall <julien@xen.org> wrote:
> >
> > Hi,
> >
> > On 18/07/2024 10:43, Julien Grall wrote:
> > > Hi Eric,
> > >
> > > On 17/07/2024 18:43, Eric Auger wrote:
> > >> Hi Peter, Richard,
> > >>
> > >> On 7/17/24 17:09, Jean-Philippe Brucker wrote:
> > >>> On Mon, Jul 15, 2024 at 08:45:00AM +0000, Mostafa Saleh wrote:
> > >>>> Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
> > >>>> but not nested instances.
> > >>>> This patch series adds support for nested translation in SMMUv3,
> > >>>> this is controlled by property “arm-smmuv3.stage=nested”, and
> > >>>> advertised to guests as (IDR0.S1P == 1 && IDR0.S2P == 2)
> > >>> For the whole series (3-9, 11, 12, 15, 16, 18):
> > >>>
> > >>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > >>>
> > >>> (and I think patch 16 is missing Eric's R-b)
> > >>
> > >> Jean-Philippe and I have followed up the progress of this series,
> > >> Mostafa took into account all our comments and all the patches were
> > >> reviewed. It seems to be in a pretty decent state so if you don't have
> > >> any objection, please consider pulling it for 9.1.
> > >>
> > >> On my end I did some testing in non nesting mode with virtio-net/vhost
> > >> and I have not noticed any regression.
> > >> Would be nice if someone could send his T-b for the nested part though
> > >> (Julien?).
> > >
> > > I haven't yet tried the latest version. I will do that in the next
> > > couple of days.
> > I see this is already merged. If this still matters:
> >
> > Tested-by: Julien Grall <jgrall@amazon.com>
> 
> We can't retrospectively add the tag, but the testing itself
> is still important -- thanks for doing it.
> 
> Q: is there any reason not to:
>  (a) change the default to "nested" rather than "1"
>  (b) make the virt board (for new virt machine versions) use
>      "nested"?
> 
> AIUI "nested" should be a superset of "stage-1 only", the guest
> can just ignore stage-2 if it doesn't care about it. Or is
> there a performance hit from having stage-2 around even if the
> guest doesn't enable it?

I didn’t do benchmarks, but from the code, I don’t think there
would be a difference from using stage-1 only or nested stages
with stage-1 config.
I didn’t make “nested” the default stage or used it for the virt
board, as I was worried about compatibility issues (I think that
breaks backward migration), but otherwise I don’t see issues.

But if I understand correctly, setting that for virt board 9.1
(virt_machine_9_1_options) would be fine?

Thanks,
Mostafa

> 
> thanks
> -- PMM

