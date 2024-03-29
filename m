Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAA2CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 18:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqGW6-0003fH-IK; Fri, 29 Mar 2024 13:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqGW4-0003eu-Ox
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 13:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqGW2-0001Hz-I6
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 13:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711735185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=SJaDB/NJB0ZbzRfojWS4a16AgoWzZWpCIT+kL89N738=;
 b=BL3Grkk+IMVc2J9KKVxU9e/FKIRxgaS6W7eIhXqGHU0kCJGHxbMp5CmV/LJFSn2tBHeRaW
 j1GOurmIS7cZ9UkIN0WF0DR0EBwE8Hc+vA+M0spXeDZHI7g+Eghm/8t5/bltZFPuNguz5a
 10j6SfiBQ+P9hWnqiC7HDksG0SdcxkQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-sm_cjqv7PPqEeLKDmyDlcg-1; Fri, 29 Mar 2024 13:59:43 -0400
X-MC-Unique: sm_cjqv7PPqEeLKDmyDlcg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3416632aeffso1037984f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 10:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711735182; x=1712339982;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SJaDB/NJB0ZbzRfojWS4a16AgoWzZWpCIT+kL89N738=;
 b=uVXrbNlCfPMNzA00AgvVQj0/U2R5k0SM6gMoDSNTjbsKAp0bf8VVLYYWGnUWQsytKC
 3WUWknGV0phNPfB+RaSuZsa0x25D7iEi3BVbZ96MlgZTg69IUSFDvXxl/odXE/2VDSnj
 3khJy6aiqC7KD4Fyv41a3OUBNdeaHC0uhmm2cxo3W06X3ri18Puxh48qC+aY8xlxWB6/
 lugQscbjblMmkbUY1oJENukbtsb3hOjHdqGiY8VEoyyCa77/y9ssiW0mG/QwfkXORlll
 +aSTSxyg2V2fU8omiOlMBf1+KLKpVSozByg5EzxQuhz3S1SxljiBvK5GRRGe/wGhvFd8
 wsAw==
X-Gm-Message-State: AOJu0YzRH+gq+Z+e3AvGM3uyljGT7XSX4Wh3GeUcucfX+J6zelX454u7
 qwlgLRlkirHXxY+vc2vSft0i4zS9b4Nwc0K0N7aeEw7oiRgesE7KmvInKBPIacD5VhO1dFU5r0Y
 BXn4PXadNNhlhkFdX/C+9frw4QMD1S3OMAknXid2Z3T4Cv6p36Qz3Nej0BtauYumP/B9kY/17Ln
 TPk5BxVQsfMRaS1T3INgXplXKXaB+oigTM3rs=
X-Received: by 2002:a5d:590f:0:b0:33d:c657:6ae3 with SMTP id
 v15-20020a5d590f000000b0033dc6576ae3mr2007025wrd.7.1711735182012; 
 Fri, 29 Mar 2024 10:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy6pZdmM1rkbbt53a0ifciGKtNhXeV7KjCz/Ml4Okf7nzOrkp50JdSEZ6i6iqzvLQgDki0azcwIcPvXwrqaCk=
X-Received: by 2002:a5d:590f:0:b0:33d:c657:6ae3 with SMTP id
 v15-20020a5d590f000000b0033dc6576ae3mr2007017wrd.7.1711735181665; Fri, 29 Mar
 2024 10:59:41 -0700 (PDT)
MIME-Version: 1.0
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 Mar 2024 18:59:30 +0100
Message-ID: <CABgObfbBSer0p3OnS7LKt53oWbWw-i=UponFGq5hQnb2rBE71w@mail.gmail.com>
Subject: Backdoor in xz, should we switch compression format for tarballs?
To: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 "Maydell, Peter" <peter.maydell@linaro.org>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007400b80614d06764"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000007400b80614d06764
Content-Type: text/plain; charset="UTF-8"

For more info, see
https://lwn.net/ml/oss-security/20240329155126.kjjfduxw2yrlxgzm@awork3.anarazel.de/
but, essentially, xz was backdoored and it seems like upstream was directly
responsible for this.

Based on this, should we switch our distribution from bz2+xz to bz2+zstd or
bz2+lzip?

Thanks,

Paolo

--0000000000007400b80614d06764
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">For more info, see=C2=A0<a href=3D"https://lwn.net/ml/oss=
-security/20240329155126.kjjfduxw2yrlxgzm@awork3.anarazel.de/">https://lwn.=
net/ml/oss-security/20240329155126.kjjfduxw2yrlxgzm@awork3.anarazel.de/</a>=
 but, essentially, xz was backdoored and it seems like upstream was directl=
y responsible for this.<div dir=3D"auto"><br></div><div dir=3D"auto">Based =
on this, should we switch our distribution from bz2+xz to bz2+zstd or bz2+l=
zip?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--0000000000007400b80614d06764--


