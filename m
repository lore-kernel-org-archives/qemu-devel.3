Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B77CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY4f8-0003YI-0o; Fri, 12 Jun 2026 12:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4eW-0003VA-G7
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4eU-0003SY-Pi
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781281356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tsCVdxg4dPr5d0VrahEOSgc/zOPOO1RcLgiETljaVk0=;
 b=V/s6GpZXYCSHgQJiowhSAie6XEyCsYb1aVQI/99joVwvQGlB8fEKh7wY+tYe6Y2xBJ9+uE
 j/3KUQO4odEQ9Nikzmc9aC8+Mz02HEdA5/QwvsBQZHqHMxGZpvdKEEL0MnwNH+tRtJ+Sop
 sgAsiuomdhc7EfYYxG8dPNPjpugn8Js=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-R1Tw4X9nNDWVpw8zWxdCyw-1; Fri, 12 Jun 2026 12:22:35 -0400
X-MC-Unique: R1Tw4X9nNDWVpw8zWxdCyw-1
X-Mimecast-MFC-AGG-ID: R1Tw4X9nNDWVpw8zWxdCyw_1781281355
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517787172b0so18046691cf.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781281355; x=1781886155; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tsCVdxg4dPr5d0VrahEOSgc/zOPOO1RcLgiETljaVk0=;
 b=UsbrEOt2305hbBDQOcF4zUwvoAfv5y66l0eY13WaotQpJevnXpATTMZIOF/awx6Kvs
 YpdlSjMeXTCql9ZSnBqW5rEf8MAzHowRqi18lO/Nlg9IScWx57IPmyQteI7c4/tBllA3
 h2hPyBt444MDPbQi52d7eFqYGm9Ds5ykGk56FMtlZErS3B6Vyi0wBUMlwxM8HuABs8Av
 TpIPp1+4Vne0S5Tbe8obv+Q+e2pRYRvkMr/RGD3x61gCqAXo1o6NGNoCKu8u28cxABRv
 UtTaEs8//vzyAi1a8qRg9+iY/nMs/0F+AYenhm5/zDbYd7e35Um77Qa9uhcDGlcLuDbK
 4DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781281355; x=1781886155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsCVdxg4dPr5d0VrahEOSgc/zOPOO1RcLgiETljaVk0=;
 b=ECAiAhZTVD+hV7NDn96mtKyafhyrf0n/aM82orLgtF0QGlCyW0C7UWl7JmirmeTPff
 od88QEUFrkgwZNMqsH7kNB+SZmdLnd5OWQ6cj081YoWhXVeUIGJjwf8DYmFkZhPESLrm
 xdBUpluA7HTMAKxTv3PhvHpNcySqvRBq6S3HE5y0mcZUsLUn1qEF7FBrldMyzALp9G7n
 LUcKGfdJN6ptTSus9xwL/8vPne+XsDQi2A4Lf1WYIR+Y+GdPiMYoFiEV8fp/Mem84Ov4
 ooM2DpETe9kkXjnauYHF8z80s+srC9ilFeMqGSe70E1KqARVg8sZehxa392Ys51RYMm6
 V4xA==
X-Gm-Message-State: AOJu0YxL0PSFPUNT6iE+zZ3H6IosV0N8+lZjdJ+gzHL63HnnNlJvhoAZ
 iV7oYhGAnHJ8mMbHFWY1H1RQ8T5m+ZNpYj4GUnphP38c4Emxi00g7dearjenKQXDApLy/QTBd5F
 d6C6pKg+38+XsBT1aUkRNeDT+WdlV5a5YG238BYr3gQcN60RLcsnbOxcF
X-Gm-Gg: Acq92OH5tI9s0YccQ4MIX3kT3npmsCDHHACMvyH8bxkXmapImrIDnQWIV3I+sDTQNnn
 PlqgGjlyH4hOJ/Z6z7jmH/p/9FzaRjUZIF21tklXSZ5mi9VGABtxaMOx8YUCE1TV7velxuiZRz9
 drwcKMicwFwjUy6U/2cy5LSgGRy/2KeLGAFhonG7qS5Hn6rWi/YqenDVoBel0o3AHjRyKXrpbhI
 wUi8CHMY0RXSMK+rZRrXo/oGhxQf5XzksjcGDl3Suzu4xkq9YanATu7TGbUvwJsJEme48tDQI6Y
 ByS2zM7WHfL0pw0YC2OR6RBzSiDsKw6xFRYzozHTsms76HFHYs9I9mxQlnP8kUG60nLESsowm1b
 egYkih2IsdhA7Mw0=
X-Received: by 2002:a05:622a:1b92:b0:516:d971:1cb1 with SMTP id
 d75a77b69052e-517fe52e028mr48539981cf.39.1781281354731; 
 Fri, 12 Jun 2026 09:22:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1b92:b0:516:d971:1cb1 with SMTP id
 d75a77b69052e-517fe52e028mr48539131cf.39.1781281354023; 
 Fri, 12 Jun 2026 09:22:34 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7a00desm26834391cf.19.2026.06.12.09.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:22:33 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:22:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v3 13/14] vfio/migration: Check VFIO_PRECOPY_INFO_REINIT
 during switchover
Message-ID: <aiwyR0JciBcpX_hm@x1.local>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-14-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609075812.32067-14-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 09, 2026 at 10:58:11AM +0300, Avihai Horon wrote:
> VFIO_REPCOPY_INFO_REINIT is checked only during precopy, before the
> switchover decision. However, the switchover decision and guest stop are
> not atomic, so a VFIO device may want to set VFIO_PRECOPY_INFO_REINIT
> and request another switchover ACK in the gap after switchover decision
> has been made but before the guest is stopped. This would be missed and
> may increase downtime.
> 
> Solve this by checking if VFIO_PRECOPY_INFO_REINIT was set during that
> gap, and request a new switchover-ack in the final save_state_pending
> call. Query precopy info after vCPUs are stopped but before
> transitioning from PRE_COPY state, when its valid to call the ioctl.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

This smells like a workaround of a not-proper kernel ABI.. but I assume
it's not a huge deal.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


