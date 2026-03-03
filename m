Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF83EB362F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRGF-0004qy-Bn; Tue, 03 Mar 2026 10:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRFz-0004ps-LI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRFt-0001Ga-I6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gqGvgtkWn2tpEBidF7xKBveNLxe9SQZngpLkSCyaZYA=;
 b=SSFYqWSUaTjZZCbxROiAPODK39ZeB6gQP7McfXBSY0pi/p5+ymt2rFF97IHoFnHmrTtlIg
 EM1vuPsd1oXmUbG/jv8hPYSr4DtaHScfArx8n8I8z9CGmZZxXoCJI+m7gNWO2thx2MJE92
 4GEkcoqQRJtKUU3EqWUAqrQs2m3b6Pk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-6UHKLQzwOFC1oUmWAkeK7A-1; Tue, 03 Mar 2026 10:01:44 -0500
X-MC-Unique: 6UHKLQzwOFC1oUmWAkeK7A-1
X-Mimecast-MFC-AGG-ID: 6UHKLQzwOFC1oUmWAkeK7A_1772550104
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c71655aa11so5722129185a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772550104; x=1773154904; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gqGvgtkWn2tpEBidF7xKBveNLxe9SQZngpLkSCyaZYA=;
 b=iqXorYaV44XbSJ24yn7U35OvFgjZP7InoX68s9QscZv9/vMNLfdBDLkmvH2EZh3+8E
 EutSPHizC8h5qIA2HGTv/faoxxhHbJwF88WeR+OkC4KLtnb7/0hxqDbICGPxwoEXzxcQ
 422EiLXQktXW7Ev1U0gln3g6UFr7OEghbFoOctB/VeTzi+dZxtwfujXcClZZAgy2Ozig
 uiYt3Ukv8Dqo62gl+WzUmq1YYHkg19zNmSVHJDrPJhgO2w3AKIGUTKvwibKMnsLGVUg5
 Vqdn+frdDFC7xaqUIg2Yo+QY4N1kBge6DWiier5yE97N7D3k7zgTJuModwtOEsw9yvse
 PxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550104; x=1773154904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqGvgtkWn2tpEBidF7xKBveNLxe9SQZngpLkSCyaZYA=;
 b=fEfFX+oNeDaL4eYTlrTo+E2SSqaXaTLr1Nkm+JEKzN42zE3uQQq1K+ND8tVoz5qlW3
 PghTLx2bMRoJJvjdiRn8fqVHPka1tniAgY7+1ljRPHrxzx3Ms66VtCRHtV8/HBqkoW3Q
 WnHYfpIMblODX9OMsuGEYot/fZE1isagXBX0ok5nuTcdrGj9hB1z+IwtMbY3qp9XujHG
 I1UkukgXw1brZMue4dnaM3xw8iCsSSnJGmqN37W0x/CKo8wZXBrD88Tkze8Xjfknl8eM
 A4h+Hq4hm3Zy96Qm/vUKc9u43mMRoBhbpHLl7+9lRqnteg5IVpu4J3fuSZjfopT8VhkD
 OM8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEolD+44pKSYGduMySZPW7vIQ1VNeRJbwtMt4oFjV+1POFDMy4065mZ5BI2q8WXaPWth7wUwJmrg4c@nongnu.org
X-Gm-Message-State: AOJu0Yz1+V8rGKI2MnZdzg3IJWAbkIWBtEnihfr19OwVXt/TijKyw+Ma
 8YwuDfLQceHat7otiaIw0XSxFKdPbrttS3kWUlCTWRbB++kQppccGBIKcFNw0DQormcsmjug4Zd
 Lc+YhOQJxizMxxCB8pC2Y3fUw8732nqWUztlw3NyNq8OwYYpMkEYMw64q
X-Gm-Gg: ATEYQzw0SOznf1SEEf9UXKHU/GB5UiFU4R5mLZiLK2lKvWoeruR425xP+ImfDYPUtiy
 QpCzVi7SyF7nivMkWvcK6k4LHDg9vr4/OduwPBgXVEj2Jnw/HSvrPOgT45093PWjk8MNXLfBbvH
 aMbosd2A3RtC9sV48no1gGI9UWFU9hQsRiy1eaDm6CpXp8Qq5J+yrIIbDW9DT/HGNDsJQivpzay
 9JebdDgKwBslsTkvukpHIokzmMSistsewRf3xls6XssXTarYxF1EqKCS07iHNYeoI/r9ynnVvTZ
 9uG61KDNwAw/vLWEEyyUgYH/qHhNlocC/+e8xwesSIOf4x0ndT4n2p56+8/WuomOl91BuQMWF51
 ZyH6V5ThLGcoe9w==
X-Received: by 2002:a05:620a:3192:b0:8cb:b062:c2e5 with SMTP id
 af79cd13be357-8cbc8dec9fbmr1994243885a.27.1772550104188; 
 Tue, 03 Mar 2026 07:01:44 -0800 (PST)
X-Received: by 2002:a05:620a:3192:b0:8cb:b062:c2e5 with SMTP id
 af79cd13be357-8cbc8dec9fbmr1994238485a.27.1772550103545; 
 Tue, 03 Mar 2026 07:01:43 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736cfasm1389538485a.49.2026.03.03.07.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:01:42 -0800 (PST)
Date: Tue, 3 Mar 2026 10:01:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 02/16] migration: make vmstate_save_state_v() static
Message-ID: <aab3y-ezwVVDkPYU@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-3-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-3-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 21, 2026 at 12:02:00AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> It's used only in vmstate.c.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


