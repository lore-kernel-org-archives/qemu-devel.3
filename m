Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBF9CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 08:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrZnl-0007ft-6a; Tue, 02 Apr 2024 04:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1rrZnK-0007aM-MZ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 04:47:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1rrZnD-0006D9-EU
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 04:47:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6eae2b57ff2so3735495b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712047490; x=1712652290;
 darn=nongnu.org; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oL6vgxClAp7LofhDvrNqyfcVSpq7wk5koSpWIuWhS14=;
 b=YdrtW66MI5rhC4Uk+K+ayOlZzoQhuxKab+GMpG897O5HtyIu4QFn0cYZQhRC/7VrvJ
 Q18ELFGPqklhkVC0kcfpwCKoBP7QqCKakmYAHxaL0FrGcjlEm8yo/oHe4hzx43dYqeym
 fcaLanh6sNEUabyRDDX3b7/gbR3sigj2pMd843wEp3hZDGUDyFb8xIXHiiZaytxqJmQL
 FR1Pr9/ArFoanPw5Dqs2Gbg0DBVQNqxVaDkqUQoMbRtdpWaIu7Fg1LHt/RglAj8EFeIS
 +v8G8vwmA/oX8IMRl5LizHUZ7+kwaqFlOEKMXbxY6yyPl9pnX8rYIkXV/BWqTfu/8J51
 T9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712047490; x=1712652290;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oL6vgxClAp7LofhDvrNqyfcVSpq7wk5koSpWIuWhS14=;
 b=uvOq6sU9uP6swbXqtrWKVoyW9TUDEN5591wAxVT98pPCENUFj00fmRGlx+x6bOVphO
 HyzCvBSs/5BkPSo9d2oEb3BdhOoIjLE85gVIaMKm3vO8SQ+IMwWbNVcpQPtAWkdgrIK0
 2Wo0Oolvd1S+GDl7ePC9tKqMMmx/STNqBhfmjblQVtyZDqtwjEkmrTLP++X+49ucWEVr
 +cbTOdc+z4YkTdzk+WnQFefmWkxrUFc2KloVJ0x37FdNh7ULe01t001R6pvRlGF5El3I
 +FaOM7s93LTS/9IOPKtWC3BtPhj2jKwfhkBfJFYX9CZ9Bq3Hecm1TiehzSaOHYBZ7jrN
 rJMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW41SSVATxpgFOKpBk4wh5vTzUoMMUsuuXJelVJVX0C4FVrrGk90PwGxHH4rK02TfWqMofbYmlKXQGc051zFv8XMa1XVqA=
X-Gm-Message-State: AOJu0YxE7BaxDVqJ7DX160ZWz2Ac6eVrzgBkhHjbvqg5d9eZXvgf6pBN
 Yba2zrvuAF/rtGIujweZImQhwetLUlWGYtIzCCMdQ9JBKf/V4yLd/yk7+H+tjMI=
X-Google-Smtp-Source: AGHT+IFiPhPv4l4741S1vk8IFYt5hCx68XGt/vkENiOMNbwR1Viw4ujbVIYy54ujwCPLf2KjJxpuYg==
X-Received: by 2002:a05:6a20:9151:b0:1a3:bfd5:f829 with SMTP id
 x17-20020a056a20915100b001a3bfd5f829mr14728553pzc.58.1712047489486; 
 Tue, 02 Apr 2024 01:44:49 -0700 (PDT)
Received: from smtpclient.apple ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a056a00191400b006e641fee598sm9560213pfi.141.2024.04.02.01.44.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Apr 2024 01:44:48 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <F5C793A7-414C-47B0-9098-37D11F115917@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_4B7D8861-BC97-4EB2-995E-C72A348E7217"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: vhost-user-blk reconnect issue
Date: Tue, 2 Apr 2024 16:44:34 +0800
In-Reply-To: <a6f3a386-4c65-4bc6-8d21-70b741919bff@nvidia.com>
Cc: =?utf-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
To: Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>
References: <DM4PR12MB5168C0DB5E4B8F30B47738F6B6362@DM4PR12MB5168.namprd12.prod.outlook.com>
 <vzwqswsxtiios4mzwab4br2utyrclkfsluwyvyw6r7gqnx55fv@z3rsaj4hs6cz>
 <add17160-7b47-4af0-908c-9c0617720cc2@nvidia.com>
 <70EC669B-52F8-408B-866B-9AFFB7EBAE96@smartx.com>
 <a6f3a386-4c65-4bc6-8d21-70b741919bff@nvidia.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_REMOTE_IMAGE=0.01 autolearn=ham autolearn_force=no
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


--Apple-Mail=_4B7D8861-BC97-4EB2-995E-C72A348E7217
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


Hi,

I tested it today and there is indeed a problem in this scenario.
It seems that the first version of the patch is the best and can handle =
all scenarios.
With this patch, the previously merged patches are no longer useful.


I will revert this patch and submit a new fix. Do you have any comments?

Revert: =
https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.16976=
44299.git.mst@redhat.com/
New: =
https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/

Thanks,
Li

> 2024=E5=B9=B44=E6=9C=881=E6=97=A5 16:43=EF=BC=8CYajun Wu =
<yajunw@nvidia.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 4/1/2024 4:34 PM, Li Feng wrote:
>>=20
>> External email: Use caution opening links or attachments              =
=20
>>=20
>> Hi yajun,
>>=20
>> I have submitted a patch to fix this problem a few months ago, but in =
the end this solution was not accepted and other solutions
>> were adopted to fix it.
>>=20
>> =
https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.com/
>>=20
> I think this fix is valid.
>=20
>> This is the merged fix:
>>=20
>>=20
>> =
https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9be.16976=
44299.git.mst@redhat.com/My tests are with this fix, failed in the two =
scenarios I mentioned.=20
>=20
>>=20
>> Thanks,
>> Li
>>=20
>>> 2024=E5=B9=B44=E6=9C=881=E6=97=A5 10:08=EF=BC=8CYajun Wu =
<yajunw@nvidia.com> <mailto:yajunw@nvidia.com> =E5=86=99=E9=81=93=EF=BC=9A=

>>>=20
>>>=20
>>> On 3/27/2024 6:47 PM, Stefano Garzarella wrote:
>>>> External email: Use caution opening links or attachments
>>>>=20
>>>>=20
>>>> Hi Yajun,
>>>>=20
>>>> On Mon, Mar 25, 2024 at 10:54:13AM +0000, Yajun Wu wrote:
>>>>> Hi experts,
>>>>>=20
>>>>> With latest QEMU (8.2.90), we find two vhost-user-blk backend =
reconnect
>>>>> failure scenarios:
>>>> Do you know if has it ever worked and so it's a regression, or have =
we
>>>> always had this problem?
>>>=20
>>> I am afraid this commit: "71e076a07d (2022-12-01 02:30:13 -0500) =
hw/virtio: generalise CHR_EVENT_CLOSED handling"  caused both failures. =
Previous hash is good.
>>>=20
>>> I suspect the "if (vhost->vdev)" in vhost_user_async_close_bh is the =
cause, previous code doesn't have this check?
>>>=20
>>>>=20
>>>> Thanks,
>>>> Stefano
>>>>=20
>>>>> 1. Disconnect vhost-user-blk backend before guest driver probe =
vblk device, then reconnect backend after guest driver probe device. =
QEMU won't send out any vhost messages to restore backend.
>>>>> This is because vhost->vdev is NULL before guest driver probe vblk =
device, so vhost_user_blk_disconnect won't be called, s->connected is =
still true. Next vhost_user_blk_connect will simply return without doing =
anything.
>>>>>=20
>>>>> 2. modprobe -r virtio-blk inside VM, then disconnect backend, then =
reconnect backend, then modprobe virtio-blk. QEMU won't send messages in =
vhost_dev_init.
>>>>> This is because rmmod will let qemu call vhost_user_blk_stop, =
vhost->vdev also become NULL(in vhost_dev_stop), =
vhost_user_blk_disconnect won't be called. Again s->connected is still =
true, even chr connect is closed.
>>>>>=20
>>>>> I think even vhost->vdev is NULL, vhost_user_blk_disconnect should =
be called when chr connect close?
>>>>> Hope we can have a fix soon.
>>>>>=20
>>>>>=20
>>>>> Thanks,
>>>>> Yajun
>>>>>=20
>>=20


--Apple-Mail=_4B7D8861-BC97-4EB2-995E-C72A348E7217
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><div>Hi,</div><div><br></div><div>I tested =
it today and there is indeed a problem in this scenario.</div><div>It =
seems that the first version of the patch is the best and can handle all =
scenarios.</div><div>With this patch, the previously merged patches are =
no longer useful.</div><div><br></div><div><br></div><div>I will revert =
this patch and submit a new fix. Do you have any =
comments?</div><div><br></div><div><div>Revert:&nbsp;<a =
href=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9=
be.1697644299.git.mst@redhat.com/">https://lore.kernel.org/all/a68c0148e9b=
f105f9e83ff5e763b8fcb6f7ba9be.1697644299.git.mst@redhat.com/</a></div><div=
>New:&nbsp;<a =
href=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx=
.com/">https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx.=
com/</a></div><div><br></div><div>Thanks,</div><div>Li</div></div><div><br=
></div><blockquote type=3D"cite"><div>2024=E5=B9=B44=E6=9C=881=E6=97=A5 =
16:43=EF=BC=8CYajun Wu &lt;yajunw@nvidia.com&gt; =E5=86=99=E9=81=93=EF=BC=9A=
</div><br class=3D"Apple-interchange-newline"><div>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
 =20
  <div><p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 4/1/2024 4:34 PM, Li Feng =
wrote:<br>
    </div>
    <blockquote type=3D"cite" =
cite=3D"mid:70EC669B-52F8-408B-866B-9AFFB7EBAE96@smartx.com">
     =20
      <table border=3D"1" bgcolor=3D"#FFEB9C">
        <tbody>
          <tr>
            <td><font size=3D"1" face=3D"verdana"><b>External
                  email: Use caution opening links or attachments</b>
              </font></td>
          </tr>
        </tbody>
      </table>
      <br>
      <div>
        <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">
          <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">
            <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">
              Hi yajun,
              <div><br>
              </div>
              <div>I have submitted a patch to fix this problem a few
                months ago, but in the end this solution was not
                accepted and other solutions</div>
              <div>were adopted to fix it.</div>
              <div><br>
              </div>
              <div>
                <div style=3D"display: block;">
                  <div style=3D"-webkit-user-select: all; =
-webkit-user-drag: element; display: inline-block;" =
class=3D"apple-rich-link" draggable=3D"true" role=3D"link" =
data-url=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@sm=
artx.com/">
                    <a =
style=3D"border-radius:10px;font-family:-apple-system, Helvetica, Arial, =
sans-serif;display:block;-webkit-user-select:none;width:300px;user-select:=
none;-webkit-user-modify:read-only;user-modify:read-only;overflow:hidden;t=
ext-decoration:none;" class=3D"lp-rich-link" rel=3D"nofollow" =
href=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx=
.com/" =
originalsrc=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli=
@smartx.com/" =
shash=3D"C6tagv56k7iKH4hU3GzpNn1wJ0qaJf06+8gRxEha2xoNhrXzrOsgsWDDTk4jwmIl+=
s2XOCP1J0XsJ6+YbZ+GApR8yFK137cOidTolUYSbdCk5G5Td206kJLZqZgh0Oa8OQtr6AJy35b=
zEv8sF7NtSTO97bRO2YvzbCWPqa7EaHA=3D" dir=3D"ltr" role=3D"button" =
draggable=3D"false" width=3D"300" moz-do-not-send=3D"true">
                      <table =
style=3D"table-layout:fixed;border-collapse:collapse;width:300px;backgroun=
d-color:#E5E6E9;font-family:-apple-system, Helvetica, Arial, =
sans-serif;" class=3D"lp-rich-link-emailBaseTable" width=3D"300" =
cellspacing=3D"0" cellpadding=3D"0" border=3D"0">
                        <tbody>
                          <tr>
                            <td vertical-align=3D"center">
                              <table style=3D"font-family:-apple-system, =
Helvetica, Arial, =
sans-serif;table-layout:fixed;background-color:rgba(229, 230, 233, 1);" =
class=3D"lp-rich-link-captionBar" width=3D"300" cellspacing=3D"0" =
cellpadding=3D"0" bgcolor=3D"#E5E6E9">
                                <tbody>
                                  <tr>
                                    <td style=3D"padding:8px 0px 8px =
0px;" class=3D"lp-rich-link-captionBar-textStackItem">
                                      <div =
style=3D"max-width:100%;margin:0px 16px 0px 16px;overflow:hidden;" =
class=3D"lp-rich-link-captionBar-textStack">
                                        <div =
style=3D"word-wrap:break-word;font-weight:500;font-size:12px;overflow:hidd=
en;text-overflow:ellipsis;text-align:left;" =
class=3D"lp-rich-link-captionBar-textStack-topCaption-leading">
                                          <a rel=3D"nofollow" =
href=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx=
.com/" =
originalsrc=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli=
@smartx.com/" =
shash=3D"xsx7V0zLzZUjW4OMnPS5fZXFo1lo6kilqtOMM2leumVckQleTN6uFjurb6A83+t1T=
L4WFFM+oeVyRtSi+kqljXOcucMliG6dLdsXKXTskHRYPFrQyMDRwT9r9NENuvNtm/yFIZhlJH7=
vlNVrg6nzdKQ9QLr5URD3C/hwHUiw2v4=3D" style=3D"text-decoration: none" =
draggable=3D"false" moz-do-not-send=3D"true"><font style=3D"" =
color=3D"#272727">[PATCH 1/2]
                                              vhost-user: fix lost
                                              reconnect - Li =
Feng</font></a></div>
                                        <div =
style=3D"word-wrap:break-word;font-weight:400;font-size:11px;overflow:hidd=
en;text-overflow:ellipsis;text-align:left;" =
class=3D"lp-rich-link-captionBar-textStack-bottomCaption-leading">
                                          <a rel=3D"nofollow" =
href=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx=
.com/" =
originalsrc=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli=
@smartx.com/" =
shash=3D"TtG+k4QeoQMw4Uo6nIN7oujAW8gSATEwbHEOXGcnFnCDu8j5/wWbzaSiQcKIiHrrh=
ikbMpcFJbv8oLRMYWyD89RLtGdbNq5tsia7BdLvLUpLzGdvlG/Okhx9eh+hcgbN51akSgJgyHn=
pKWpq2fPssqnoWE5+sRM/wjGj6QrHiTw=3D" style=3D"text-decoration: none" =
draggable=3D"false" moz-do-not-send=3D"true"><font style=3D"" =
color=3D"#808080">lore.kernel.org</font></a></div>
                                      </div>
                                    </td>
                                    <td style=3D"padding:0px 12px 0px =
0px;" class=3D"lp-rich-link-captionBar-rightIconItem" width=3D"36">
                                      <a rel=3D"nofollow" =
href=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli@smartx=
.com/" =
originalsrc=3D"https://lore.kernel.org/all/20230804052954.2918915-2-fengli=
@smartx.com/" =
shash=3D"cIUcSFQU8wgPcQovkb6qLefSrVOlLyGbySgghyxlb3Yl0+eBNdnIfXeoowldHFBv5=
HDpDgVjwOk/0ID0EEqXR3ZfWx+QCUi4Ws9Afmijkj+wO2POKvE9mFE3YgZ9w6vyULXCKrWknHe=
xtgG4YmgbcSRyuKm5DLhMlfujPHlFlaE=3D" draggable=3D"false" =
moz-do-not-send=3D"true"><img =
src=3D"data:image/png;base64,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3D=
" draggable=3D"false" style=3D"pointer-events:none =
!important;display:inline-block;width:36px;height:36px;" =
class=3D"lp-rich-link-captionBar-rightIcon" moz-do-not-send=3D"true" =
width=3D"36" height=3D"36"></a></td>
                                  </tr>
                                </tbody>
                              </table>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </a></div>
                </div>
                <div><br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote><p>I think this fix is valid.<br>
    </p>
    <blockquote type=3D"cite" =
cite=3D"mid:70EC669B-52F8-408B-866B-9AFFB7EBAE96@smartx.com">
      <div>
        <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">
          <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">
            <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">
              <div>
                <div>
                </div>
                This is the merged fix:</div>
              <div><br>
              </div>
              <div><br>
              </div>
              <div>
                <div style=3D"display: block;">
                  <div style=3D"-webkit-user-select: all; =
-webkit-user-drag: element; display: inline-block;" =
class=3D"apple-rich-link" draggable=3D"true" role=3D"link" =
data-url=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f=
7ba9be.1697644299.git.mst@redhat.com/">
                    <a =
style=3D"border-radius:10px;font-family:-apple-system, Helvetica, Arial, =
sans-serif;display:block;-webkit-user-select:none;width:300px;user-select:=
none;-webkit-user-modify:read-only;user-modify:read-only;overflow:hidden;t=
ext-decoration:none;" class=3D"lp-rich-link" rel=3D"nofollow" =
href=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9=
be.1697644299.git.mst@redhat.com/" =
originalsrc=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fc=
b6f7ba9be.1697644299.git.mst@redhat.com/" =
shash=3D"o690TPSGdWnn0ZbUx6QF/RZrrnSnyscTbtiJj+4Qh19WeQj/uQwTikL+eLPiHp6vp=
jlV5aHlxp3O7toOOjxWU6/04z1P9KTwEod4QU2CrbJZftwB9VL0qD24YaicOqlD8LmNNB4vC8Q=
0VobpGqhaI+6p6Gbu6Q+/WXD0QSWFMKU=3D" dir=3D"ltr" role=3D"button" =
draggable=3D"false" width=3D"300" moz-do-not-send=3D"true">
                      <table =
style=3D"table-layout:fixed;border-collapse:collapse;width:300px;backgroun=
d-color:#E5E6E9;font-family:-apple-system, Helvetica, Arial, =
sans-serif;" class=3D"lp-rich-link-emailBaseTable" width=3D"300" =
cellspacing=3D"0" cellpadding=3D"0" border=3D"0">
                        <tbody>
                          <tr>
                            <td vertical-align=3D"center">
                              <table style=3D"font-family:-apple-system, =
Helvetica, Arial, =
sans-serif;table-layout:fixed;background-color:rgba(229, 230, 233, 1);" =
class=3D"lp-rich-link-captionBar" width=3D"300" cellspacing=3D"0" =
cellpadding=3D"0" bgcolor=3D"#E5E6E9">
                                <tbody>
                                  <tr>
                                    <td style=3D"padding:8px 0px 8px =
0px;" class=3D"lp-rich-link-captionBar-textStackItem">
                                      <div =
style=3D"max-width:100%;margin:0px 16px 0px 16px;overflow:hidden;" =
class=3D"lp-rich-link-captionBar-textStack">
                                        <div =
style=3D"word-wrap:break-word;font-weight:500;font-size:12px;overflow:hidd=
en;text-overflow:ellipsis;text-align:left;" =
class=3D"lp-rich-link-captionBar-textStack-topCaption-leading">
                                          <a rel=3D"nofollow" =
href=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9=
be.1697644299.git.mst@redhat.com/" =
originalsrc=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fc=
b6f7ba9be.1697644299.git.mst@redhat.com/" =
shash=3D"qnpvnX4reHqPw3XyUx63PdXSmk+f0hT0FdWe0QN9jiAb3ePGRKD5uj8Uu7eHq0WML=
OM9stm0LoprAX4F4Y+pTxm0YL7C6+Tn8lWV6um/z9mSVO4u+zo27fdqLySBGrPc4JGhcys27oN=
pit8e4r308FOyD1vM6+OpSZ+yzEzI8Hc=3D" style=3D"text-decoration: none" =
draggable=3D"false" moz-do-not-send=3D"true"><font style=3D"" =
color=3D"#272727">[PULL 76/83]
                                              vhost-user: fix lost
                                              reconnect - Michael S.
                                              Tsirkin</font></a></div>
                                        <div =
style=3D"word-wrap:break-word;font-weight:400;font-size:11px;overflow:hidd=
en;text-overflow:ellipsis;text-align:left;" =
class=3D"lp-rich-link-captionBar-textStack-bottomCaption-leading">
                                          <a rel=3D"nofollow" =
href=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9=
be.1697644299.git.mst@redhat.com/" =
originalsrc=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fc=
b6f7ba9be.1697644299.git.mst@redhat.com/" =
shash=3D"RSn5TF9P2G2pOEJul3iGVFApCALoZzWTPKUvLGiHGwAjoKq7nCRWqQcCcgStK5A1g=
11hWCnVZu7NK+bkITRuhWl0XpONkINUhDV6/p61N/N4K9j2bu9ljOM4MMLv2DAhN6gjQwgcVNW=
c7xPQ/y0z1t4EddJnttp6GAuV5Z39f/k=3D" style=3D"text-decoration: none" =
draggable=3D"false" moz-do-not-send=3D"true"><font style=3D"" =
color=3D"#808080">lore.kernel.org</font></a></div>
                                      </div>
                                    </td>
                                    <td style=3D"padding:0px 12px 0px =
0px;" class=3D"lp-rich-link-captionBar-rightIconItem" width=3D"36">
                                      <a rel=3D"nofollow" =
href=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fcb6f7ba9=
be.1697644299.git.mst@redhat.com/" =
originalsrc=3D"https://lore.kernel.org/all/a68c0148e9bf105f9e83ff5e763b8fc=
b6f7ba9be.1697644299.git.mst@redhat.com/" =
shash=3D"DfQZCCmwlpH2uRRCtVSBnpUx6smuHWcGbVPP0MGX7pjDzerTQhCV/5OUBA1FHdcLf=
JmTRfRMNhNF/VjgNBqkaNtQZ+nKvFo/izxjU7c3rh8IQnCX9ePVCBeIeKnRa/sfYj/qHmlmZ0H=
r0oBGIx1HKRCc/2JCMJVEkuq/KGU7VLU=3D" draggable=3D"false" =
moz-do-not-send=3D"true"><img =
src=3D"data:image/png;base64,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3D=
" draggable=3D"false" style=3D"pointer-events:none =
!important;display:inline-block;width:36px;height:36px;" =
class=3D"lp-rich-link-captionBar-rightIcon" moz-do-not-send=3D"true" =
width=3D"36" height=3D"36"></a></td>
                                  </tr>
                                </tbody>
                              </table>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </a></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote><p>My tests are with this fix, failed in the two =
scenarios I
      mentioned. <br>
    </p>
    <blockquote type=3D"cite" =
cite=3D"mid:70EC669B-52F8-408B-866B-9AFFB7EBAE96@smartx.com">
      <div>
        <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">
          <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">
            <div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;">
              <div>
                <div style=3D"display: block;">
                </div>
                <div><br>
                </div>
                Thanks,</div>
              <div>Li<br>
                <div><br>
                  <blockquote type=3D"cite">
                    <div>2024=E5=B9=B44=E6=9C=881=E6=97=A5 10:08=EF=BC=8CY=
ajun Wu
                      <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:yajunw@nvidia.com">&lt;yajunw@nvidia.com&gt;</a> =
=E5=86=99=E9=81=93=EF=BC=9A</div>
                    <br class=3D"Apple-interchange-newline">
                    <div>
                      <div><br>
                        On 3/27/2024 6:47 PM, Stefano Garzarella =
wrote:<br>
                        <blockquote type=3D"cite">External email: Use
                          caution opening links or attachments<br>
                          <br>
                          <br>
                          Hi Yajun,<br>
                          <br>
                          On Mon, Mar 25, 2024 at 10:54:13AM +0000,
                          Yajun Wu wrote:<br>
                          <blockquote type=3D"cite">Hi experts,<br>
                            <br>
                            With latest QEMU (8.2.90), we find two
                            vhost-user-blk backend reconnect<br>
                            failure scenarios:<br>
                          </blockquote>
                          Do you know if has it ever worked and so it's
                          a regression, or have we<br>
                          always had this problem?<br>
                        </blockquote>
                        <br>
                        I am afraid this commit: "71e076a07d (2022-12-01
                        02:30:13 -0500) hw/virtio: generalise
                        CHR_EVENT_CLOSED handling"&nbsp; caused both
                        failures. Previous hash is good.<br>
                        <br>
                        I suspect the "if (vhost-&gt;vdev)" in
                        vhost_user_async_close_bh is the cause, previous
                        code doesn't have this check?<br>
                        <br>
                        <blockquote type=3D"cite"><br>
                          Thanks,<br>
                          Stefano<br>
                          <br>
                          <blockquote type=3D"cite">1. Disconnect
                            vhost-user-blk backend before guest driver
                            probe vblk device, then reconnect backend
                            after guest driver probe device. QEMU won't
                            send out any vhost messages to restore
                            backend.<br>
                            This is because vhost-&gt;vdev is NULL
                            before guest driver probe vblk device, so
                            vhost_user_blk_disconnect won't be called,
                            s-&gt;connected is still true. Next
                            vhost_user_blk_connect will simply return
                            without doing anything.<br>
                            <br>
                            2. modprobe -r virtio-blk inside VM, then
                            disconnect backend, then reconnect backend,
                            then modprobe virtio-blk. QEMU won't send
                            messages in vhost_dev_init.<br>
                            This is because rmmod will let qemu call
                            vhost_user_blk_stop, vhost-&gt;vdev also
                            become NULL(in vhost_dev_stop),
                            vhost_user_blk_disconnect won't be called.
                            Again s-&gt;connected is still true, even
                            chr connect is closed.<br>
                            <br>
                            I think even vhost-&gt;vdev is NULL,
                            vhost_user_blk_disconnect should be called
                            when chr connect close?<br>
                            Hope we can have a fix soon.<br>
                            <br>
                            <br>
                            Thanks,<br>
                            Yajun<br>
                            <br>
                          </blockquote>
                        </blockquote>
                      </div>
                    </div>
                  </blockquote>
                </div>
                <br>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </div>

</div></blockquote></div><br></body></html>=

--Apple-Mail=_4B7D8861-BC97-4EB2-995E-C72A348E7217--

