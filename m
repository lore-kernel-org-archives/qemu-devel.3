Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC3AC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 11:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4f7n-0005E4-8N; Wed, 08 May 2024 07:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nlw7ZgsKCn0bmfy.cfooffmjobsp.pshrfnv-efwfmopohov.psh@calendar-server.bounces.google.com>)
 id 1s4f7k-0005Dj-V0
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:06:13 -0400
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nlw7ZgsKCn0bmfy.cfooffmjobsp.pshrfnv-efwfmopohov.psh@calendar-server.bounces.google.com>)
 id 1s4f7h-0006OI-T4
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:06:12 -0400
Received: by mail-ed1-x549.google.com with SMTP id
 4fb4d7f45d1cf-5725715b9beso703393a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 04:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715166367; x=1715771167; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B7QPj5MRHtrpSLGxeGQl/Iw8tn2O6EJSkD56IUVIz0c=;
 b=u3ir/Lv8m/JdVaJk09YXCoTOIubKkkn1c/mmZa8T7A9kS15izrul99i3bdB8BMCUne
 WRdoNB+1HRhlQuHeLlc2JrFZCjUTJlik9rSpXNxrBaxuJNltrCriJ5NEskP8BYCXOpun
 mTM9nkZUDkTegzz+yxyaZtkm/GIcx6kfuNL7L5PbKc0CdZHL+Pc1dDkYLmiS2F8AWQ2q
 /8WCxGxiQTxqOk5XFu75T95t6qHTv7ITk6rohmWOer7x0zq59PszCDZovjhU1IV/mKTO
 Inmd9knVprPxdr+Mvw7g2qtt9MQAqse2K3IYMqYeUk5vAgu5Vj14IuqLSG+85891z574
 rovA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715166367; x=1715771167; darn=nongnu.org;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B7QPj5MRHtrpSLGxeGQl/Iw8tn2O6EJSkD56IUVIz0c=;
 b=nrkWHmAXu618SD1PdsZ7oWVRmhedwgnjSNN0rJxYu/KtlH+ZiGqzfeA4NMTKFkHeez
 oFcQ0faFH+AhMC7gR8Fb3i2WZNBn8I3ze5d5a8m+7n9AcuGaEPrl7gSOlVN1HX+ezBVH
 T3adaI2D3j8fIdpmc4xvK+VBfKdd3fq0egQoYcDt9Lb7VUtnek4yVmpMefmWmCqnXtc6
 /D+3+Pu3r2qIRIBFEN7Fx+x3OvAZ0gTC4W3sndurECHqPyGY+Yw21jIN90uYUHCNJPqu
 7xa8MSJmsQ3FJkkvi0xlV4nsSO8MPa2j0h/dpc2T/5ONP1jShfOom5mnkzk4o0wPGL1o
 2wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715166367; x=1715771167;
 h=to:from:subject:date:message-id:auto-submitted:sender:reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B7QPj5MRHtrpSLGxeGQl/Iw8tn2O6EJSkD56IUVIz0c=;
 b=pxfGgQEgJAeYIfok+f7m0cgd7YffOCAxvmLeYwNm4qXDwvbdJiblBn9XSm1ramuqg9
 aEX14VriVxkdaQahLmmfAMmlSqbNQYyOr3BApPbD6/q/gGz04LDzm+HPW9YImLKohapi
 2v+IilEJiJWK55kgWuhYlVO2EU72ISBR6OUZS7a9rcFhn6FmQA/lNV57BdEdrOP0YtBk
 Hb3gWv/LkMyNa5wk4uaqCyxk0IbnnhUYKsQySI8v3lzBc0TITGHccxfEPnfoBCdO5BKE
 K0ERtzTXdQDGZ16KDW4lopcYcLdgz8z6WvHp6ocDWa032aFFdmsMOYOgchM07wjMZ6h/
 73Ig==
X-Gm-Message-State: AOJu0YwbYDFqtoRuzV/HBtgHTHdMam4CTW0egtaopuAOO1yYrf0uRvOx
 MiBENRtwEBQJ/07iw6CUm5x8z9AgdrnZnyovq6tIeMNwqsTmH60iXDjFbuT8TaIQjwhynOS/BtJ
 XEZhzRi/39P66Z9pqKtpJlTDQXJMsic7suAZVq4Uhhej0c1l/+Q==
X-Google-Smtp-Source: AGHT+IEoCdu/GCNY9DlpwMHNAJps91Kxti6D6W05cycXr44+VeBBTSFc3rvFweQDXrgc+e3GLgXA359SwzdjKWrSK7dL
MIME-Version: 1.0
X-Received: by 2002:aa7:c2d3:0:b0:572:5122:4845 with SMTP id
 4fb4d7f45d1cf-5731101d43fmr4594454a12.4.1715166366974; Wed, 08 May 2024
 04:06:06 -0700 (PDT)
Auto-Submitted: auto-generated
Message-ID: <calendar-d1b402e8-4982-47ac-ac08-dc5d9a41c469@google.com>
Date: Wed, 08 May 2024 11:06:06 +0000
Subject: Canceled event with note: QEMU/KVM developers conference call @ Tue
 14 May 2024 14:00 - 15:00 (BST) (qemu-devel@nongnu.org)
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="00000000000008cffd0617ef4a95"
Received-SPF: pass client-ip=2a00:1450:4864:20::549;
 envelope-from=3nlw7ZgsKCn0bmfy.cfooffmjobsp.pshrfnv-efwfmopohov.psh@calendar-server.bounces.google.com;
 helo=mail-ed1-x549.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_FONT_LOW_CONTRAST=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000008cffd0617ef4a95
Content-Type: multipart/alternative; boundary="00000000000008cffc0617ef4a93"

--00000000000008cffc0617ef4a93
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

VGhpcyBldmVudCBoYXMgYmVlbiBjYW5jZWxlZCB3aXRoIGEgbm90ZToNCiJDYW5jZWxsZWQgYmVj
YXVzZSBMaW5hcm8gYXJlIGF0IENvbm5lY3QgYXMgd2VsbCBhcyBhIG51bWJlciBvZiByZWd1bGFy
ICANCmF0ZW5kZWVzLiINCg0KUUVNVS9LVk0gZGV2ZWxvcGVycyBjb25mZXJlbmNlIGNhbGwNClR1
ZXNkYXkgMTQgTWF5IDIwMjQg4ouFIDE0OjAwIOKAkyAxNTowMA0KVW5pdGVkIEtpbmdkb20gVGlt
ZQ0KDQpMb2NhdGlvbg0KaHR0cHM6Ly9tZWV0LmppdC5zaS9rdm1jYWxsbWVldGluZwkNCmh0dHBz
Oi8vd3d3Lmdvb2dsZS5jb20vdXJsP3E9aHR0cHMlM0ElMkYlMkZtZWV0LmppdC5zaSUyRmt2bWNh
bGxtZWV0aW5nJnNhPUQmdXN0PTE3MTU1OTgzNjAwMDAwMDAmdXNnPUFPdlZhdzFuZFdIb194em16
c0FvbGJEYlNjbXoNCg0KDQoNCkF0dGFjaG1lbnRzDQpOb3RlcyDigJMgUUVNVS9LVk0gZGV2ZWxv
cGVycyBjb25mZXJlbmNlIGNhbGwgIA0KaHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZG9jdW1lbnQv
ZC8xLUx0cTExTEx6eENjY2ZxZk5OS2NNRzc0SE1VSmY2RFVSbVNKQkdRWnJlay9lZGl0DQoNCklm
IHlvdSBuZWVkIGNhbGwgZGV0YWlscywgcGxlYXNlIGNvbnRhY3QgbWU6IGFsZXguYmVubmVlQGxp
bmFyby5vcmcNCg0KR3Vlc3RzDQphbGVAcmV2Lm5nDQpBbGV4IEJlbm7DqWUNCmFsaXN0YWlyLmZy
YW5jaXNAd2RjLmNvbQ0KYXJtYnJ1QHJlZGhhdC5jb20NCmJjYWluQHF1aWNpbmMuY29tDQpiZXJy
YW5nZUByZWRoYXQuY29tDQpjamlhQG52aWRpYS5jb20NCmNsZ0BrYW9kLm9yZw0KY3dAZjAwZi5v
cmcNCmVibGFrZUByZWRoYXQuY29tDQplZGdhci5pZ2xlc2lhc0BnbWFpbC5jb20NCmVkdWFyZG9A
aGFia29zdC5uZXQNCmZlbGlwZUBudXRhbml4LmNvbQ0KaWdneUB0aGVpZ2d5LmNvbQ0KaW1wQGJz
ZGltcC5jb20NCmpnZ0BudmlkaWEuY29tDQpqaWRvbmcueGlhb0BnbWFpbC5jb20NCmppbS5zaHVA
c2lmaXZlLmNvbQ0Ka29ucmFkLndpbGtAb3JhY2xlLmNvbQ0KbWJ1cnRvbkBxdGkucXVhbGNvbW0u
Y29tDQptZGVhbkByZWRoYXQuY29tDQpwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20NCnBib256aW5p
QHJlZGhhdC5jb20NClBldGVyIE1heWRlbGwNClJpY2hhcmQgSGVuZGVyc29uDQpzaGVudGV5QGdt
YWlsLmNvbQ0Kc3RlZmFuaGFAZ21haWwuY29tDQp3ZWkudy53YW5nQGludGVsLmNvbQ0Kend1Lmtl
cm5lbEBnbWFpbC5jb20NClBoaWwgTWF0aGlldS1EYXVkw6kNCmVibG90QHJpdm9zaW5jLmNvbQ0K
bWF4LmNob3VAc2lmaXZlLmNvbQ0KYWZhZXJiZXJAc3VzZS5kZQ0KQW50b24gSm9oYW5zc29uDQpi
YmF1bWFuQHJlZGhhdC5jb20NCkNoYW8gUGVuZw0KRGFtaWVuIEhlZGRlDQpFbGVuYSBVZmltdHNl
dmENCmVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KamFuLmtpc3prYUB3ZWIuZGUNCmpqaGVybmVAbGlu
dXgudm5ldC5pYm0uY29tDQpKb2FvIE1hcnRpbnMNCkx1YyBNaWNoZWwNCm1pbXVAbGludXgudm5l
dC5pYm0uY29tDQpTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQp6Lmh1b0AxMzkuY29tDQpMSVUg
Wmhpd2VpDQpxZW11LWRldmVsQG5vbmdudS5vcmcNCg0KDQp+fi8vfn4NCkludml0YXRpb24gZnJv
bSBHb29nbGUgQ2FsZW5kYXI6IGh0dHBzOi8vY2FsZW5kYXIuZ29vZ2xlLmNvbS9jYWxlbmRhci8N
Cg0KWW91IGFyZSByZWNlaXZpbmcgdGhpcyBlbWFpbCBiZWNhdXNlIHlvdSBhcmUgYW4gYXR0ZW5k
ZWUgb24gdGhlIGV2ZW50LiBUbyAgDQpzdG9wIHJlY2VpdmluZyBmdXR1cmUgdXBkYXRlcyBmb3Ig
dGhpcyBldmVudCwgZGVjbGluZSB0aGlzIGV2ZW50Lg0KDQpGb3J3YXJkaW5nIHRoaXMgaW52aXRh
dGlvbiBjb3VsZCBhbGxvdyBhbnkgcmVjaXBpZW50IHRvIHNlbmQgYSByZXNwb25zZSB0byAgDQp0
aGUgb3JnYW5pemVyLCBiZSBhZGRlZCB0byB0aGUgZ3Vlc3QgbGlzdCwgaW52aXRlIG90aGVycyBy
ZWdhcmRsZXNzIG9mICANCnRoZWlyIG93biBpbnZpdGF0aW9uIHN0YXR1cywgb3IgbW9kaWZ5IHlv
dXIgUlNWUC4NCg0KTGVhcm4gbW9yZSBodHRwczovL3N1cHBvcnQuZ29vZ2xlLmNvbS9jYWxlbmRh
ci9hbnN3ZXIvMzcxMzUjZm9yd2FyZGluZw0K
--00000000000008cffc0617ef4a93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!doctype html><html xmlns=3D"http://www.w3.org/1999/xhtml" xmlns:v=3D"urn:=
schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-microsoft-com:office:offi=
ce"><head><title></title><!--[if !mso]><meta http-equiv=3D"X-UA-Compatible"=
 content=3D"IE=3Dedge"><![endif]--><meta http-equiv=3D"Content-Type" conten=
t=3D"text/html; charset=3DUTF-8"><meta name=3D"viewport" content=3D"width=
=3Ddevice-width,initial-scale=3D1"><meta name=3D"color-scheme" content=3D"l=
ight dark"><meta name=3D"supported-color-schemes" content=3D"light dark">
    <style>
      body, html {
        font-family: Roboto, Helvetica, Arial, sans-serif;
      }

      body {
        margin: 0;
        padding: 0;
        -webkit-font-smoothing: antialiased;
        -webkit-text-size-adjust: 100%;
        -ms-text-size-adjust: 100%;
      }

      #outlook a {
        padding: 0;
      }

      .ReadMsgBody {
        width: 100%;
      }

      .ExternalClass {
        width: 100%;
      }

      .ExternalClass * {
        line-height: 100%;
      }

      table,
      td {
        mso-table-lspace: 0pt;
        mso-table-rspace: 0pt;
      }

      img {
        border: 0;
        height: auto;
        line-height: 100%;
        outline: none;
        text-decoration: none;
        -ms-interpolation-mode: bicubic;
      }

      p {
        display: block;
        margin: 13px 0;
      }
    </style>
    <!--[if !mso]><!-->
    <style>
      @media only screen and (max-width:580px) {
        @-ms-viewport {
          width: 320px;
        }

        @viewport {
          width: 320px;
        }
      }
    </style>
    <!--<![endif]-->
    <!--[if mso]>
          <xml>
          <o:OfficeDocumentSettings>
            <o:AllowPNG/>
            <o:PixelsPerInch>96</o:PixelsPerInch>
          </o:OfficeDocumentSettings>
          </xml>
          <![endif]-->
    <!--[if lte mso 11]>
          <style>
            .outlook-group-fix { width:100% !important; }
          </style>
    <![endif]-->

    <!--[if !mso]><!-- -->
  <style>body, html {font-family:Roboto,Helvetica,Arial,sans-serif;}@font-f=
ace {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOmCnqEu92Fr1Mu4mxP.ttf) forma=
t('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmEU9fBBc9.ttf) f=
ormat('truetype');
}
@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmWUlfBBc9.ttf) f=
ormat('truetype');
}
@font-face {
  font-family: 'Material Icons Extended';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/materialiconsextended/v151/kJEjBvgX7BgnkSr=
UwT8UnLVc38YydejYY-oE_LvM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialicons/v141/Gw6kwdfw6UnXLJCcm=
afZyFRXb3BL9rvi0QZG3g.otf) format('opentype');
}

.google-material-icons {
  font-family: 'Google Material Icons';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}
@font-face {
  font-family: 'Google Material Icons Filled';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialiconsfilled/v116/WWXFlimHYg6=
HKI3TavMkbKdhBmDvgach8TVpeGsuueSZJH4.otf) format('opentype');
}

.google-material-icons-filled {
  font-family: 'Google Material Icons Filled';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UaGrENHsxJlGDuGo1OIlL3Owps=
.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLU94Yt=
zCwM.ttf) format('truetype');
}
@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLV154t=
zCwM.ttf) format('truetype');
}
</style><!--<![endif]-->
      <style>
        .body-container {
          padding-left: 16px;
          padding-right: 16px;
        }
      </style>
 =20
      <style>
        u+.body .body-container,
        body[data-outlook-cycle] .body-container,
        #MessageViewBody .body-container {
          padding-left: 0;
          padding-right: 0;
        }
      </style>
 =20
    <style>
      @media only screen and (min-width:580px) {
        .column-per-37 {
          width: 37% !important;
          max-width: 37%;
        }

        .column-per-63 {
          width: 63% !important;
          max-width: 63%;
        }
      }
    </style>
 =20
    <style>
      .appointment-buttons th {
        display: block;
        clear: both;
        float: left;
        margin-top: 12px;
      }

      .appointment-buttons th a {
        float: left;
      }

      #MessageViewBody .appointment-buttons th {
       margin-top: 24px;
      }
    </style>
 =20
    <style>
      @media only screen and (max-width:580px) {
        table.full-width-mobile {
          width: 100% !important;
        }

        td.full-width-mobile {
          width: auto !important;
        }
      }
    </style>
    <style>
      .main-container-inner,
      .info-bar-inner {
        padding: 12px 16px !important;
      }

      .main-column-table-ltr {
        padding-right: 0 !important;
      }

      .main-column-table-rtl {
        padding-left: 0 !important;
      }

      @media only screen and (min-width:580px) {
        .main-container-inner {
          padding: 24px 32px !important;
        }

        .info-bar-inner {
          padding: 12px 32px !important;
        }

        .main-column-table-ltr {
          padding-right: 32px !important;
        }

        .main-column-table-rtl {
          padding-left: 32px !important;
        }

        .appointment-buttons th {
          display: table-cell;
          clear: none;
        }
      }

      .primary-text {
        color: #3c4043 !important;
      }

      .secondary-text,
      .phone-number a {
        color: #70757a !important;
      }

      .accent-text {
        color: #1a73e8 !important;
      }

      .accent-text-dark {
        color: #185abc !important;
      }

      .grey-button-text,
      .attachment-chip a {
        color: #5f6368 !important;
      }

      .primary-button {
        background-color: #1a73e8 !important;
      }

      .primary-button-text {
        color: #fff !important;
      }

      .underline-on-hover:hover {
        text-decoration: underline !important;
      }

      .grey-infobar-text {
        color: #202124 !important;
      }

      @media (prefers-color-scheme: dark) {
        .primary-text:not([class^=3D"x_"]) {
          color: #e8eaed !important;
        }

        .secondary-text:not([class^=3D"x_"]),
        .phone-number:not([class^=3D"x_"]) a {
          color: #9aa0a6 !important;
        }

        .grey-button-text:not([class^=3D"x_"]),
        .attachment-chip:not([class^=3D"x_"]) a {
          color: #bdc1c6 !important;
        }

        .accent-text:not([class^=3D"x_"]),
        .hairline-button-text:not([class^=3D"x_"]) {
          color: #8ab4f8 !important;
        }

        .primary-button:not([class^=3D"x_"]) {
          background-color: #8ab4f8 !important;
        }

        .primary-button-text:not([class^=3D"x_"]) {
          color: #202124 !important;
        }
      }
    </style>
    <style>
      @media (prefers-color-scheme: dark) {
        .cse-banner:not([class^=3D"x_"]) {
          background-color: #3c4043 !important; /* Google Grey 800 */
        }

        .encryption-icon:not([class^=3D"x_"]) {
          /* WARNING: This causes the whole style tag to get stripped in Gm=
ail. */
          background-image: url('https://fonts.gstatic.com/s/i/googlemateri=
aliconsfilled/encrypted/v3/gm_grey200-24dp/2x/gm_filled_encrypted_gm_grey20=
0_24dp.png') !important;
        }
      }
    </style>
    <!--[if !mso]><!-->
    <style>
      .prevent-link a {
        color: inherit !important;
        text-decoration: none !important;
        font-size: inherit !important;
        font-family: inherit !important;
        font-weight: inherit !important;
        line-height: inherit !important;
      }
    </style>
    <!--<![endif]-->

    <!--[if mso | IE]>
      <style>
        .main-container-inner {
          padding: 24px 32px !important;
        }

        .info-bar-inner {
          padding: 12px 32px !important;
        }

        .cse-banner .encryption-icon {
          /* We use the IE workaround instead. */
          background-image: none !important;
        }

        .cse-banner .encryption-icon .ms-fallback {
          display: block !important;
        }

        /* NB: Some MS clients ignore dark-scheme styling and apply their o=
wn, so there's nothing we can do to help there. */
        @media (prefers-color-scheme: dark) {
          .cse-banner:not([class^=3D"x_"]) .encryption-icon .ms-fallback {
            display: none !important;
          }

          .cse-banner:not([class^=3D"x_"]) .encryption-icon .ms-fallback-da=
rk {
            display: block !important;
          }
        }
      </style>
    <![endif]-->
  </head><body class=3D"body"><span itemscope itemtype=3D"http://schema.org=
/InformAction"><span itemprop=3D"object" itemscope itemtype=3D"http://schem=
a.org/Event"><meta itemprop=3D"eventStatus" content=3D"http://schema.org/Ev=
entCancelled"/><span itemprop=3D"publisher" itemscope itemtype=3D"http://sc=
hema.org/Organization"><meta itemprop=3D"name" content=3D"Google Calendar"/=
></span><meta itemprop=3D"eventId/googleCalendar" content=3D"1gvub9435o7hrr=
em0a0ralnl5i_20240514T130000Z"/><span style=3D"display: none; font-size: 1p=
x; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-w=
idth: 0; opacity: 0; overflow: hidden;" itemprop=3D"name">QEMU/KVM develope=
rs conference call</span><span aria-hidden=3D"true"><time itemprop=3D"start=
Date" datetime=3D"20240514T130000Z"></time><time itemprop=3D"endDate" datet=
ime=3D"20240514T140000Z"></time></span><table border=3D"0" cellpadding=3D"0=
" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:1=
00%;" class=3D"body-container"><tbody><tr><td style=3D"" class=3D"" align=
=3D"left"><!--[if mso | IE]><table border=3D"0" cellpadding=3D"0" cellspaci=
ng=3D"0" role=3D"presentation"><tr><td height=3D"16" style=3D"height:16px;"=
><![endif]--><div style=3D"height:16px;" aria-hidden=3D"true"> &nbsp; </div=
><!--[if mso | IE]></td></tr></table><![endif]--><table border=3D"0" cellpa=
dding=3D"0" cellspacing=3D"0" role=3D"presentation" align=3D"center" style=
=3D"width:100%;" class=3D""><tbody><tr><td style=3D"background-color: #fce8=
e6;color: #2d0c0c;padding: 12px 32px; border-radius: 8px;font-family: Robot=
o, sans-serif;font-size: 14px; line-height: 20px;text-align: left;" class=
=3D"info-bar-inner"><span style=3D"font-weight: 700;">This event has been c=
anceled with a note:</span><br/>"Cancelled because Linaro are at Connect as=
 well as a number of regular atendees."</td></tr></tbody></table><!--[if ms=
o | IE]><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"pre=
sentation"><tr><td height=3D"12" style=3D"height:12px;"><![endif]--><div st=
yle=3D"height:12px;" aria-hidden=3D"true"> &nbsp; </div><!--[if mso | IE]><=
/td></tr></table><![endif]--><table border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" role=3D"presentation" align=3D"center" style=3D"width:100%;" clas=
s=3D""><tbody><tr><td style=3D"border: solid 1px #dadce0; border-radius: 8p=
x; direction: rtl; font-size: 0; padding: 24px 32px; text-align: left; vert=
ical-align: top;" class=3D"main-container-inner"><!--[if mso | IE]><table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation"><tr><=
![endif]--><!--[if mso | IE]><td class=3D"" style=3D"vertical-align:top;wid=
th:37%;" ><![endif]--><div class=3D"column-per-37 outlook-group-fix" style=
=3D"font-size: 13px; text-align: left; direction: ltr; display: inline-bloc=
k; vertical-align: top; width: 100%;overflow: hidden; word-wrap: break-word=
;"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presenta=
tion" width=3D"100%"><tbody><tr><td style=3D"vertical-align:top;padding:0;"=
><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentati=
on" width=3D"100%"><tr><td style=3D"font-size: 0; padding: 0; text-align: l=
eft; word-break: break-word;;padding-bottom:0px;"><div style=3D"font-family=
: Roboto, sans-serif;font-size: 14px; line-height: 20px; mso-line-height-ru=
le: exactly; text-align: left;" class=3D"primary-text" role=3D"presentation=
"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentat=
ion" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" styl=
e=3D"font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700=
;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Attachments</h=
2></td></tr></table></div></td></tr><tr><td style=3D"font-size: 0; padding:=
 0; text-align: left; word-break: break-word;;padding-bottom:24px;padding-l=
eft: 1px; padding-right: 1px;"><table border=3D"0" cellpadding=3D"0" cellsp=
acing=3D"0" role=3D"presentation" class=3D"attachment-chip" style=3D"border=
: solid 1px #dadce0; border-radius: 16px; border-collapse: separate; paddin=
g: 4px 0 4px 0;"><tr><td style=3D"padding: 3px 10px; height: 14px; width: 1=
4px;"><img src=3D"https://drive-thirdparty.googleusercontent.com/16/type/ap=
plication/vnd.google-apps.document" width=3D"14" height=3D"14" alt=3D"" sty=
le=3D"display: inline-block; vertical-align: middle;"></td><td align=3D"lef=
t" style=3D"padding: 0; padding-left: 0; padding-right: 10px; max-width: 16=
0px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><div =
style=3D"overflow: hidden; height: 20px;"><a href=3D"https://docs.google.co=
m/document/d/1-Ltq11LLzxCccfqfNNKcMG74HMUJf6DURmSJBGQZrek/edit" target=3D"_=
blank" style=3D"font-weight: 400;font-family: &#39;Google Sans&#39;, Roboto=
, sans-serif;color: #5f6368; font-size: 14px; line-height: 120%; mso-line-h=
eight-rule: exactly; margin: 0; text-decoration: none; text-transform: none=
;;font-family: Roboto, sans-serif;; display: inline-block; height: 20px; ma=
x-width: 160px; line-height: 20px; overflow: hidden; text-overflow: ellipsi=
s; vertical-align: middle; white-space: normal;" class=3D"grey-button-text"=
 title=3D"Notes =E2=80=93 QEMU/KVM developers conference call">Notes =E2=80=
=93 QEMU/KVM devel...</a></div></td></tr></table></td></tr></table></td></t=
r></tbody></table></div><!--[if mso | IE]></td><![endif]--><!--[if mso | IE=
]><td class=3D"" style=3D"vertical-align:top;width:63%;padding-right:32px;"=
 ><![endif]--><div class=3D"column-per-63 outlook-group-fix" style=3D"font-=
size: 13px; text-align: left; direction: ltr; display: inline-block; vertic=
al-align: top; width: 100%;overflow: hidden; word-wrap: break-word;"><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" wid=
th=3D"100%" class=3D"main-column-table-ltr" style=3D"padding-right: 32px; p=
adding-left: 0;;table-layout: fixed;"><tbody><tr><td class=3D"main-column-t=
d" style=3D"padding:0; vertical-align:top;"><table border=3D"0" cellpadding=
=3D"0" cellspacing=3D"0" role=3D"presentation" width=3D"100%" style=3D"tabl=
e-layout: fixed;"><tr><td style=3D"font-size: 0; padding: 0; text-align: le=
ft; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-family=
: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px;=
 line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: =
none;" class=3D"primary-text" role=3D"presentation"><span>If you need call =
details, please contact me: <a href=3D"mailto:quintela@redhat.com" target=
=3D"_blank">alex.bennee@linaro.org</a></span><meta itemprop=3D"description"=
 content=3D"If you need call details, please contact me: alex.bennee@linaro=
.org"/></div></td></tr><tr><td style=3D"font-size: 0; padding: 0; text-alig=
n: left; word-break: break-word;;padding-bottom:24px;"><div style=3D"font-f=
amily: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: =
14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decorat=
ion: none;" class=3D"primary-text" role=3D"presentation"><span aria-hidden=
=3D"true"><time itemprop=3D"startDate" datetime=3D"20240514T130000Z"></time=
><time itemprop=3D"endDate" datetime=3D"20240514T140000Z"></time></span><ta=
ble border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" =
style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"=
font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-web=
kit-font-smoothing: antialiased;margin: 0; padding: 0;">When</h2></td></tr>=
</table><span>Tuesday 14 May 2024 =E2=8B=85 14:00 =E2=80=93 15:00 (United K=
ingdom Time)</span></div></td></tr><tr><td style=3D"font-size: 0; padding: =
0; text-align: left; word-break: break-word;;padding-bottom:24px;"><div sty=
le=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400;=
 font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; =
text-decoration: none;" class=3D"primary-text" role=3D"presentation"><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" sty=
le=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"primary-text" style=3D"fon=
t-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit=
-font-smoothing: antialiased;margin: 0; padding: 0;">Location</h2></td></tr=
></table><span itemprop=3D"location" itemscope itemtype=3D"http://schema.or=
g/Place"><span itemprop=3D"name" class=3D"primary-text notranslate" style=
=3D"font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; f=
ont-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; te=
xt-decoration: none;">https://meet.jit.si/kvmcallmeeting</span><br/><a href=
=3D"https://www.google.com/url?q=3Dhttps%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeti=
ng&amp;sa=3DD&amp;ust=3D1715598360000000&amp;usg=3DAOvVaw1ndWHo_xzmzsAolbDb=
Scmz" class=3D"accent-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #1a73e8; text-decoration: none;font-weight: 700;" target=3D"_bla=
nk" itemprop=3D"map">View map</a></span></div></td></tr><tr><td style=3D"fo=
nt-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-b=
ottom:24px;"><div style=3D"font-family: Roboto, sans-serif;font-style: norm=
al; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0=
.2px;color: #3c4043; text-decoration: none;" class=3D"primary-text" role=3D=
"presentation"><table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=
=3D"presentation" style=3D"padding-bottom: 4px;"><tr><td><h2 class=3D"prima=
ry-text" style=3D"font-size: 14px;color: #3c4043; text-decoration: none;fon=
t-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">G=
uests</h2></td></tr></table><div style=3D"padding-bottom: 4px; text-align: =
left;;color: #3c4042;"><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:ale@rev.ng">ale@r=
ev.ng</a></span><meta itemprop=3D"email" content=3D"ale@rev.ng"/></span><sp=
an class=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;=
"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http:=
//schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=
=3D"primary-text underline-on-hover" style=3D"display: inline-block;;color:=
 #3c4043; text-decoration: none;" href=3D"mailto:alex.bennee@linaro.org">Al=
ex Benn=C3=A9e</a></span><meta itemprop=3D"email" content=3D"alex.bennee@li=
naro.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; t=
ext-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemsc=
ope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"=
notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display:=
 inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:alist=
air.francis@wdc.com">alistair.francis@wdc.com</a></span><meta itemprop=3D"e=
mail" content=3D"alistair.francis@wdc.com"/></span><span class=3D"secondary=
-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div><=
span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person">=
<span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text unde=
rline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decora=
tion: none;" href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a></span>=
<meta itemprop=3D"email" content=3D"armbru@redhat.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:bcain@quicinc.com">bcain@quicinc.c=
om</a></span><meta itemprop=3D"email" content=3D"bcain@quicinc.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:berrange@redhat.com">b=
errange@redhat.com</a></span><meta itemprop=3D"email" content=3D"berrange@r=
edhat.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a; =
text-decoration: none;"></span></div><div><span itemprop=3D"attendee" items=
cope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D=
"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"display=
: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:cjia=
@nvidia.com">cjia@nvidia.com</a></span><meta itemprop=3D"email" content=3D"=
cjia@nvidia.com"/></span><span class=3D"secondary-text" style=3D"color: #70=
757a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee"=
 itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" cl=
ass=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"d=
isplay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailt=
o:clg@kaod.org">clg@kaod.org</a></span><meta itemprop=3D"email" content=3D"=
clg@kaod.org"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:c=
w@f00f.org">cw@f00f.org</a></span><meta itemprop=3D"email" content=3D"cw@f0=
0f.org"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:eblake@=
redhat.com">eblake@redhat.com</a></span><meta itemprop=3D"email" content=3D=
"eblake@redhat.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a></span><meta i=
temprop=3D"email" content=3D"edgar.iglesias@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:eduardo@habkost.net">eduardo@habko=
st.net</a></span><meta itemprop=3D"email" content=3D"eduardo@habkost.net"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:felipe@nutanix.c=
om">felipe@nutanix.com</a></span><meta itemprop=3D"email" content=3D"felipe=
@nutanix.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:i=
ggy@theiggy.com">iggy@theiggy.com</a></span><meta itemprop=3D"email" conten=
t=3D"iggy@theiggy.com"/></span><span class=3D"secondary-text" style=3D"colo=
r: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"att=
endee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"na=
me" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" styl=
e=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D=
"mailto:imp@bsdimp.com">imp@bsdimp.com</a></span><meta itemprop=3D"email" c=
ontent=3D"imp@bsdimp.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></span><meta itemprop=3D"email=
" content=3D"jgg@nvidia.com"/></span><span class=3D"secondary-text" style=
=3D"color: #70757a; text-decoration: none;"></span></div><div><span itempro=
p=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span itempr=
op=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hov=
er" style=3D"display: inline-block;;color: #3c4043; text-decoration: none;"=
 href=3D"mailto:jidong.xiao@gmail.com">jidong.xiao@gmail.com</a></span><met=
a itemprop=3D"email" content=3D"jidong.xiao@gmail.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:jim.shu@sifive.com">jim.shu@sifive=
.com</a></span><meta itemprop=3D"email" content=3D"jim.shu@sifive.com"/></s=
pan><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration=
: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=
=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"=
><a class=3D"primary-text underline-on-hover" style=3D"display: inline-bloc=
k;;color: #3c4043; text-decoration: none;" href=3D"mailto:konrad.wilk@oracl=
e.com">konrad.wilk@oracle.com</a></span><meta itemprop=3D"email" content=3D=
"konrad.wilk@oracle.com"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:mburton@qti.qualcomm.com">mburton@qti.qualcomm.com</a></span><me=
ta itemprop=3D"email" content=3D"mburton@qti.qualcomm.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:mdean@redhat.com">mdean@redhat.=
com</a></span><meta itemprop=3D"email" content=3D"mdean@redhat.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:paul.walmsley@sifive.c=
om">paul.walmsley@sifive.com</a></span><meta itemprop=3D"email" content=3D"=
paul.walmsley@sifive.com"/></span><span class=3D"secondary-text" style=3D"c=
olor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"=
attendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D=
"name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" s=
tyle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a></span><meta itempro=
p=3D"email" content=3D"pbonzini@redhat.com"/></span><span class=3D"secondar=
y-text" style=3D"color: #70757a; text-decoration: none;"></span></div><div>=
<span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"=
><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text und=
erline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decor=
ation: none;" href=3D"mailto:peter.maydell@linaro.org">Peter Maydell</a></s=
pan><meta itemprop=3D"email" content=3D"peter.maydell@linaro.org"/></span><=
span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: non=
e;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"htt=
p://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a cla=
ss=3D"primary-text underline-on-hover" style=3D"display: inline-block;;colo=
r: #3c4043; text-decoration: none;" href=3D"mailto:richard.henderson@linaro=
.org">Richard Henderson</a></span><meta itemprop=3D"email" content=3D"richa=
rd.henderson@linaro.org"/></span><span class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"a=
ttendee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"=
name" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" st=
yle=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=
=3D"mailto:shentey@gmail.com">shentey@gmail.com</a></span><meta itemprop=3D=
"email" content=3D"shentey@gmail.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a></span><me=
ta itemprop=3D"email" content=3D"stefanha@gmail.com"/></span><span class=3D=
"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span></=
div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.or=
g/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary=
-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043; t=
ext-decoration: none;" href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@inte=
l.com</a></span><meta itemprop=3D"email" content=3D"wei.w.wang@intel.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:zwu.kernel@gmail=
.com">zwu.kernel@gmail.com</a></span><meta itemprop=3D"email" content=3D"zw=
u.kernel@gmail.com"/></span><span class=3D"secondary-text" style=3D"color: =
#70757a; text-decoration: none;"></span></div><div><span itemprop=3D"attend=
ee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name"=
 class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:philmd@linaro.org">Phil Mathieu-Daud=C3=A9</a></span><meta itemprop=
=3D"email" content=3D"philmd@linaro.org"/></span><span class=3D"secondary-t=
ext" style=3D"color: #70757a; text-decoration: none;"></span></div><div><sp=
an itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><s=
pan itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underl=
ine-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decorati=
on: none;" href=3D"mailto:eblot@rivosinc.com">eblot@rivosinc.com</a></span>=
<meta itemprop=3D"email" content=3D"eblot@rivosinc.com"/></span><span class=
=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></span=
></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema=
.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"prim=
ary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4043=
; text-decoration: none;" href=3D"mailto:max.chou@sifive.com">max.chou@sifi=
ve.com</a></span><meta itemprop=3D"email" content=3D"max.chou@sifive.com"/>=
</span><span class=3D"secondary-text" style=3D"color: #70757a; text-decorat=
ion: none;"></span></div><div><span itemprop=3D"attendee" itemscope itemtyp=
e=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate=
"><a class=3D"primary-text underline-on-hover" style=3D"display: inline-blo=
ck;;color: #3c4043; text-decoration: none;" href=3D"mailto:afaerber@suse.de=
">afaerber@suse.de</a></span><meta itemprop=3D"email" content=3D"afaerber@s=
use.de"/></span><span class=3D"secondary-text" style=3D"color: #70757a; tex=
t-decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscop=
e itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"no=
translate"><a class=3D"primary-text underline-on-hover" style=3D"display: i=
nline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:anjo@re=
v.ng">Anton Johansson</a></span><meta itemprop=3D"email" content=3D"anjo@re=
v.ng"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-=
decoration: none;"></span></div><div><span itemprop=3D"attendee" itemscope =
itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notr=
anslate"><a class=3D"primary-text underline-on-hover" style=3D"display: inl=
ine-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:bbauman@r=
edhat.com">bbauman@redhat.com</a></span><meta itemprop=3D"email" content=3D=
"bbauman@redhat.com"/></span><span class=3D"secondary-text" style=3D"color:=
 #70757a; text-decoration: none;"></span></div><div><span itemprop=3D"atten=
dee" itemscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name=
" class=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=
=3D"display: inline-block;;color: #3c4043; text-decoration: none;" href=3D"=
mailto:chao.p.peng@linux.intel.com">Chao Peng</a></span><meta itemprop=3D"e=
mail" content=3D"chao.p.peng@linux.intel.com"/></span><span class=3D"second=
ary-text" style=3D"color: #70757a; text-decoration: none;"></span></div><di=
v><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Perso=
n"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text u=
nderline-on-hover" style=3D"display: inline-block;;color: #3c4043; text-dec=
oration: none;" href=3D"mailto:dhedde@kalrayinc.com">Damien Hedde</a></span=
><meta itemprop=3D"email" content=3D"dhedde@kalrayinc.com"/></span><span cl=
ass=3D"secondary-text" style=3D"color: #70757a; text-decoration: none;"></s=
pan></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://sch=
ema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"p=
rimary-text underline-on-hover" style=3D"display: inline-block;;color: #3c4=
043; text-decoration: none;" href=3D"mailto:elena.ufimtseva@oracle.com">Ele=
na Ufimtseva</a></span><meta itemprop=3D"email" content=3D"elena.ufimtseva@=
oracle.com"/></span><span class=3D"secondary-text" style=3D"color: #70757a;=
 text-decoration: none;"></span></div><div><span itemprop=3D"attendee" item=
scope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:e=
ric.auger@redhat.com">eric.auger@redhat.com</a></span><meta itemprop=3D"ema=
il" content=3D"eric.auger@redhat.com"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:jan.kiszka@web.de">jan.kiszka@web.de</a></span><meta=
 itemprop=3D"email" content=3D"jan.kiszka@web.de"/></span><span class=3D"se=
condary-text" style=3D"color: #70757a; text-decoration: none;"></span></div=
><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/P=
erson"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-te=
xt underline-on-hover" style=3D"display: inline-block;;color: #3c4043; text=
-decoration: none;" href=3D"mailto:jjherne@linux.vnet.ibm.com">jjherne@linu=
x.vnet.ibm.com</a></span><meta itemprop=3D"email" content=3D"jjherne@linux.=
vnet.ibm.com"/></span><span class=3D"secondary-text" style=3D"color: #70757=
a; text-decoration: none;"></span></div><div><span itemprop=3D"attendee" it=
emscope itemtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=
=3D"notranslate"><a class=3D"primary-text underline-on-hover" style=3D"disp=
lay: inline-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:j=
oao.m.martins@oracle.com">Joao Martins</a></span><meta itemprop=3D"email" c=
ontent=3D"joao.m.martins@oracle.com"/></span><span class=3D"secondary-text"=
 style=3D"color: #70757a; text-decoration: none;"></span></div><div><span i=
temprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span =
itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline-=
on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration: =
none;" href=3D"mailto:luc@lmichel.fr">Luc Michel</a></span><meta itemprop=
=3D"email" content=3D"luc@lmichel.fr"/></span><span class=3D"secondary-text=
" style=3D"color: #70757a; text-decoration: none;"></span></div><div><span =
itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/Person"><span=
 itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-text underline=
-on-hover" style=3D"display: inline-block;;color: #3c4043; text-decoration:=
 none;" href=3D"mailto:mimu@linux.vnet.ibm.com">mimu@linux.vnet.ibm.com</a>=
</span><meta itemprop=3D"email" content=3D"mimu@linux.vnet.ibm.com"/></span=
><span class=3D"secondary-text" style=3D"color: #70757a; text-decoration: n=
one;"></span></div><div><span itemprop=3D"attendee" itemscope itemtype=3D"h=
ttp://schema.org/Person"><span itemprop=3D"name" class=3D"notranslate"><a c=
lass=3D"primary-text underline-on-hover" style=3D"display: inline-block;;co=
lor: #3c4043; text-decoration: none;" href=3D"mailto:shameerali.kolothum.th=
odi@huawei.com">Shameerali Kolothum Thodi</a></span><meta itemprop=3D"email=
" content=3D"shameerali.kolothum.thodi@huawei.com"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:z.huo@139.com">z.huo@139.com</a></span>=
<meta itemprop=3D"email" content=3D"z.huo@139.com"/></span><span class=3D"s=
econdary-text" style=3D"color: #70757a; text-decoration: none;"></span></di=
v><div><span itemprop=3D"attendee" itemscope itemtype=3D"http://schema.org/=
Person"><span itemprop=3D"name" class=3D"notranslate"><a class=3D"primary-t=
ext underline-on-hover" style=3D"display: inline-block;;color: #3c4043; tex=
t-decoration: none;" href=3D"mailto:zhiwei_liu@linux.alibaba.com">LIU Zhiwe=
i</a></span><meta itemprop=3D"email" content=3D"zhiwei_liu@linux.alibaba.co=
m"/></span><span class=3D"secondary-text" style=3D"color: #70757a; text-dec=
oration: none;"></span></div><div><span itemprop=3D"attendee" itemscope ite=
mtype=3D"http://schema.org/Person"><span itemprop=3D"name" class=3D"notrans=
late"><a class=3D"primary-text underline-on-hover" style=3D"display: inline=
-block;;color: #3c4043; text-decoration: none;" href=3D"mailto:qemu-devel@n=
ongnu.org">qemu-devel@nongnu.org</a></span><meta itemprop=3D"email" content=
=3D"qemu-devel@nongnu.org"/></span><span class=3D"secondary-text" style=3D"=
color: #70757a; text-decoration: none;"></span></div></div></div></td></tr>=
</table></td></tr></tbody></table></div><!--[if mso | IE]></td><![endif]-->=
<!--[if mso | IE]></tr></table><![endif]--></td></tr></tbody></table><table=
 border=3D"0" cellpadding=3D"0" cellspacing=3D"0" role=3D"presentation" ali=
gn=3D"center" style=3D"width:100%;" class=3D""><tbody><tr><td style=3D"font=
-size: 0; padding: 0; text-align: left; word-break: break-word;;padding:4px=
 12px;" class=3D"" align=3D"left"><div class=3D"secondary-text" style=3D"co=
lor: #70757a; text-decoration: none;font-family: Roboto, sans-serif;font-si=
ze: 12px; line-height: 16px; mso-line-height-rule: exactly; text-align: lef=
t;"><p>Invitation from <a href=3D"https://calendar.google.com/calendar/" cl=
ass=3D"accent-text underline-on-hover" style=3D"font-family: Roboto, sans-s=
erif;font-size: 12px; line-height: 16px; mso-line-height-rule: exactly;;col=
or: #1a73e8; text-decoration: none;" target=3D"_blank">Google Calendar</a><=
/p><p>You are receiving this email because you are an attendee on the event=
. To stop receiving future updates for this event, decline this event.</p><=
p>Forwarding this invitation could allow any recipient to send a response t=
o the organizer, be added to the guest list, invite others regardless of th=
eir own invitation status, or modify your RSVP. <a class=3D"accent-text und=
erline-on-hover" style=3D"font-family: Roboto, sans-serif;font-size: 12px; =
line-height: 16px; mso-line-height-rule: exactly;;color: #1a73e8; text-deco=
ration: none;" href=3D"https://support.google.com/calendar/answer/37135#for=
warding">Learn more</a></p></div></td></tr></tbody></table></td></tr></tbod=
y></table></span></span></body></html>
--00000000000008cffc0617ef4a93
Content-Type: text/calendar; charset="UTF-8"; method=CANCEL
Content-Transfer-Encoding: quoted-printable

BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:CANCEL
BEGIN:VTIMEZONE
TZID:America/New_York
X-LIC-LOCATION:America/New_York
BEGIN:DAYLIGHT
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
TZNAME:EDT
DTSTART:19700308T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D3;BYDAY=3D2SU
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:-0400
TZOFFSETTO:-0500
TZNAME:EST
DTSTART:19701101T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D11;BYDAY=3D1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTART;TZID=3DAmerica/New_York:20240514T090000
DTEND;TZID=3DAmerica/New_York:20240514T100000
DTSTAMP:20240508T110606Z
ORGANIZER;CN=3DQEMU Project Calendar:mailto:c_k5p2lpgvbptdirku5si01blmnk@gr=
ou
 p.calendar.google.com
UID:1gvub9435o7hrrem0a0ralnl5i_R20240319T130000@google.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dal
 e@rev.ng;X-NUM-GUESTS=3D0:mailto:ale@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;X-N=
UM-GUE
 STS=3D0:mailto:alex.bennee@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dal
 istair.francis@wdc.com;X-NUM-GUESTS=3D0:mailto:alistair.francis@wdc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dar
 mbru@redhat.com;X-NUM-GUESTS=3D0:mailto:armbru@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dbc
 ain@quicinc.com;X-NUM-GUESTS=3D0:mailto:bcain@quicinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dbe
 rrange@redhat.com;X-NUM-GUESTS=3D0:mailto:berrange@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dcj
 ia@nvidia.com;X-NUM-GUESTS=3D0:mailto:cjia@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dcl
 g@kaod.org;X-NUM-GUESTS=3D0:mailto:clg@kaod.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dcw
 @f00f.org;X-NUM-GUESTS=3D0:mailto:cw@f00f.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Deb
 lake@redhat.com;X-NUM-GUESTS=3D0:mailto:eblake@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Ded
 gar.iglesias@gmail.com;X-NUM-GUESTS=3D0:mailto:edgar.iglesias@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Deduar
 do@habkost.net;X-NUM-GUESTS=3D0:mailto:eduardo@habkost.net
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dfe
 lipe@nutanix.com;X-NUM-GUESTS=3D0:mailto:felipe@nutanix.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dig
 gy@theiggy.com;X-NUM-GUESTS=3D0:mailto:iggy@theiggy.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dim
 p@bsdimp.com;X-NUM-GUESTS=3D0:mailto:imp@bsdimp.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Djg
 g@nvidia.com;X-NUM-GUESTS=3D0:mailto:jgg@nvidia.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dji
 dong.xiao@gmail.com;X-NUM-GUESTS=3D0:mailto:jidong.xiao@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dji
 m.shu@sifive.com;X-NUM-GUESTS=3D0:mailto:jim.shu@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dko
 nrad.wilk@oracle.com;X-NUM-GUESTS=3D0:mailto:konrad.wilk@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dmb
 urton@qti.qualcomm.com;X-NUM-GUESTS=3D0:mailto:mburton@qti.qualcomm.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DDECLINED;CN=
=3Dmdean@
 redhat.com;X-NUM-GUESTS=3D0;X-RESPONSE-COMMENT=3D"Declined because I am ou=
t of=20
 office":mailto:mdean@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Dpaul.
 walmsley@sifive.com;X-NUM-GUESTS=3D0:mailto:paul.walmsley@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dpb
 onzini@redhat.com;X-NUM-GUESTS=3D0:mailto:pbonzini@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DPe
 ter Maydell;X-NUM-GUESTS=3D0:mailto:peter.maydell@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DRi
 chard Henderson;X-NUM-GUESTS=3D0:mailto:richard.henderson@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Dshent
 ey@gmail.com;X-NUM-GUESTS=3D0:mailto:shentey@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Dstefa
 nha@gmail.com;X-NUM-GUESTS=3D0:mailto:stefanha@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dwe
 i.w.wang@intel.com;X-NUM-GUESTS=3D0:mailto:wei.w.wang@intel.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dzw
 u.kernel@gmail.com;X-NUM-GUESTS=3D0:mailto:zwu.kernel@gmail.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;X-NUM
 -GUESTS=3D0:mailto:philmd@linaro.org
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DTENTATIVE;CN=
=3Deblot
 @rivosinc.com;X-NUM-GUESTS=3D0:mailto:eblot@rivosinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dma
 x.chou@sifive.com;X-NUM-GUESTS=3D0:mailto:max.chou@sifive.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Daf
 aerber@suse.de;X-NUM-GUESTS=3D0:mailto:afaerber@suse.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DAn
 ton Johansson;X-NUM-GUESTS=3D0:mailto:anjo@rev.ng
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dbb
 auman@redhat.com;X-NUM-GUESTS=3D0:mailto:bbauman@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DCh
 ao Peng;X-NUM-GUESTS=3D0:mailto:chao.p.peng@linux.intel.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DACCEPTED;CN=
=3DDamien
  Hedde;X-NUM-GUESTS=3D0:mailto:dhedde@kalrayinc.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DEl
 ena Ufimtseva;X-NUM-GUESTS=3D0:mailto:elena.ufimtseva@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Der
 ic.auger@redhat.com;X-NUM-GUESTS=3D0:mailto:eric.auger@redhat.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dja
 n.kiszka@web.de;X-NUM-GUESTS=3D0:mailto:jan.kiszka@web.de
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Djj
 herne@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:jjherne@linux.vnet.ibm.co=
m
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DJo
 ao Martins;X-NUM-GUESTS=3D0:mailto:joao.m.martins@oracle.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DLu
 c Michel;X-NUM-GUESTS=3D0:mailto:luc@lmichel.fr
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dmi
 mu@linux.vnet.ibm.com;X-NUM-GUESTS=3D0:mailto:mimu@linux.vnet.ibm.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DSh
 ameerali Kolothum Thodi;X-NUM-GUESTS=3D0:mailto:shameerali.kolothum.thodi@=
hua
 wei.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dz.
 huo@139.com;X-NUM-GUESTS=3D0:mailto:z.huo@139.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3DLI
 U Zhiwei;X-NUM-GUESTS=3D0:mailto:zhiwei_liu@linux.alibaba.com
ATTENDEE;CUTYPE=3DINDIVIDUAL;ROLE=3DREQ-PARTICIPANT;PARTSTAT=3DNEEDS-ACTION=
;CN=3Dqe
 mu-devel@nongnu.org;X-NUM-GUESTS=3D0:mailto:qemu-devel@nongnu.org
RECURRENCE-ID;TZID=3DAmerica/New_York:20240514T090000
CREATED:20230221T153950Z
DESCRIPTION:If you need call details\, please contact me: <a href=3D"mailto=
:q
 uintela@redhat.com">alex.bennee@linaro.org</a>
LAST-MODIFIED:20240508T110603Z
LOCATION:https://meet.jit.si/kvmcallmeeting
SEQUENCE:1
STATUS:CANCELLED
SUMMARY:QEMU/KVM developers conference call
TRANSP:OPAQUE
ATTACH;FILENAME=3DNotes =E2=80=93 QEMU/KVM developers conference call;FMTTY=
PE=3Dapplica
 tion/vnd.google-apps.document:https://docs.google.com/document/d/1-Ltq11LL=
z
 xCccfqfNNKcMG74HMUJf6DURmSJBGQZrek/edit
BEGIN:VALARM
ACTION:EMAIL
DESCRIPTION:This is an event reminder
SUMMARY:Alarm notification
ATTENDEE:mailto:qemu-devel@nongnu.org
TRIGGER:-P2D
END:VALARM
END:VEVENT
END:VCALENDAR

--00000000000008cffc0617ef4a93--

--00000000000008cffd0617ef4a95
Content-Type: application/ics; name="invite.ics"
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vR29vZ2xlIEluYy8vR29vZ2xlIENhbGVuZGFyIDcw
LjkwNTQvL0VODQpWRVJTSU9OOjIuMA0KQ0FMU0NBTEU6R1JFR09SSUFODQpNRVRIT0Q6Q0FOQ0VM
DQpCRUdJTjpWVElNRVpPTkUNClRaSUQ6QW1lcmljYS9OZXdfWW9yaw0KWC1MSUMtTE9DQVRJT046
QW1lcmljYS9OZXdfWW9yaw0KQkVHSU46REFZTElHSFQNClRaT0ZGU0VURlJPTTotMDUwMA0KVFpP
RkZTRVRUTzotMDQwMA0KVFpOQU1FOkVEVA0KRFRTVEFSVDoxOTcwMDMwOFQwMjAwMDANClJSVUxF
OkZSRVE9WUVBUkxZO0JZTU9OVEg9MztCWURBWT0yU1UNCkVORDpEQVlMSUdIVA0KQkVHSU46U1RB
TkRBUkQNClRaT0ZGU0VURlJPTTotMDQwMA0KVFpPRkZTRVRUTzotMDUwMA0KVFpOQU1FOkVTVA0K
RFRTVEFSVDoxOTcwMTEwMVQwMjAwMDANClJSVUxFOkZSRVE9WUVBUkxZO0JZTU9OVEg9MTE7QllE
QVk9MVNVDQpFTkQ6U1RBTkRBUkQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0KRFRTVEFS
VDtUWklEPUFtZXJpY2EvTmV3X1lvcms6MjAyNDA1MTRUMDkwMDAwDQpEVEVORDtUWklEPUFtZXJp
Y2EvTmV3X1lvcms6MjAyNDA1MTRUMTAwMDAwDQpEVFNUQU1QOjIwMjQwNTA4VDExMDYwNloNCk9S
R0FOSVpFUjtDTj1RRU1VIFByb2plY3QgQ2FsZW5kYXI6bWFpbHRvOmNfazVwMmxwZ3ZicHRkaXJr
dTVzaTAxYmxtbmtAZ3JvdQ0KIHAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ0KVUlEOjFndnViOTQzNW83
aHJyZW0wYTByYWxubDVpX1IyMDI0MDMxOVQxMzAwMDBAZ29vZ2xlLmNvbQ0KQVRURU5ERUU7Q1VU
WVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9O
O0NOPWFsDQogZUByZXYubmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmFsZUByZXYubmcNCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPURFQ0xJ
TkVEO1gtTlVNLUdVRQ0KIFNUUz0wOm1haWx0bzphbGV4LmJlbm5lZUBsaW5hcm8ub3JnDQpBVFRF
TkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVE
Uy1BQ1RJT047Q049YWwNCiBpc3RhaXIuZnJhbmNpc0B3ZGMuY29tO1gtTlVNLUdVRVNUUz0wOm1h
aWx0bzphbGlzdGFpci5mcmFuY2lzQHdkYy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1hcg0KIG1icnVA
cmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YXJtYnJ1QHJlZGhhdC5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtDTj1iYw0KIGFpbkBxdWljaW5jLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YmNh
aW5AcXVpY2luYy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJ
Q0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1iZQ0KIHJyYW5nZUByZWRoYXQuY29tO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpiZXJyYW5nZUByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9
SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049
Y2oNCiBpYUBudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpjamlhQG52aWRpYS5jb20N
CkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFU
PU5FRURTLUFDVElPTjtDTj1jbA0KIGdAa2FvZC5vcmc7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmNs
Z0BrYW9kLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWN3DQogQGYwMGYub3JnO1gtTlVNLUdVRVNUUz0w
Om1haWx0bzpjd0BmMDBmLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWViDQogbGFrZUByZWRoYXQuY29t
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzplYmxha2VAcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NO
PWVkDQogZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZWRnYXIu
aWdsZXNpYXNAZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1Q
QVJUSUNJUEFOVDtQQVJUU1RBVD1URU5UQVRJVkU7Q049ZWR1YXINCiBkb0BoYWJrb3N0Lm5ldDtY
LU5VTS1HVUVTVFM9MDptYWlsdG86ZWR1YXJkb0BoYWJrb3N0Lm5ldA0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NO
PWZlDQogbGlwZUBudXRhbml4LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86ZmVsaXBlQG51dGFu
aXguY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1ORUVEUy1BQ1RJT047Q049aWcNCiBneUB0aGVpZ2d5LmNvbTtYLU5VTS1HVUVTVFM9
MDptYWlsdG86aWdneUB0aGVpZ2d5LmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9M
RT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPWltDQogcEBic2RpbXAu
Y29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzppbXBAYnNkaW1wLmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NO
PWpnDQogZ0BudmlkaWEuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqZ2dAbnZpZGlhLmNvbQ0K
QVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9
TkVFRFMtQUNUSU9OO0NOPWppDQogZG9uZy54aWFvQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86amlkb25nLnhpYW9AZ21haWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049amkNCiBtLnNodUBz
aWZpdmUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqaW0uc2h1QHNpZml2ZS5jb20NCkFUVEVO
REVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURT
LUFDVElPTjtDTj1rbw0KIG5yYWQud2lsa0BvcmFjbGUuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0
bzprb25yYWQud2lsa0BvcmFjbGUuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049bWINCiB1cnRvbkBxdGku
cXVhbGNvbW0uY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYnVydG9uQHF0aS5xdWFsY29tbS5j
b20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPURFQ0xJTkVEO0NOPW1kZWFuQA0KIHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA7WC1SRVNQ
T05TRS1DT01NRU5UPSJEZWNsaW5lZCBiZWNhdXNlIEkgYW0gb3V0IG9mIA0KIG9mZmljZSI6bWFp
bHRvOm1kZWFuQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPVRFTlRBVElWRTtDTj1wYXVsLg0KIHdhbG1zbGV5QHNpZml2
ZS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbQ0KQVRU
RU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO0NOPXBiDQogb256aW5pQHJlZGhhdC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRv
OnBib256aW5pQHJlZGhhdC5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVR
LVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1QZQ0KIHRlciBNYXlkZWxsO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcNCkFUVEVOREVFO0NV
VFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElP
TjtDTj1SaQ0KIGNoYXJkIEhlbmRlcnNvbjtYLU5VTS1HVUVTVFM9MDptYWlsdG86cmljaGFyZC5o
ZW5kZXJzb25AbGluYXJvLm9yZw0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEt
UEFSVElDSVBBTlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO0NOPXNoZW50DQogZXlAZ21haWwuY29tO1gt
TlVNLUdVRVNUUz0wOm1haWx0bzpzaGVudGV5QGdtYWlsLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlO
RElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9VEVOVEFUSVZFO0NOPXN0ZWZh
DQogbmhhQGdtYWlsLmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86c3RlZmFuaGFAZ21haWwuY29t
DQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RB
VD1ORUVEUy1BQ1RJT047Q049d2UNCiBpLncud2FuZ0BpbnRlbC5jb207WC1OVU0tR1VFU1RTPTA6
bWFpbHRvOndlaS53LndhbmdAaW50ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtS
T0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049encNCiB1Lmtlcm5l
bEBnbWFpbC5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOnp3dS5rZXJuZWxAZ21haWwuY29tDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047WC1OVU0NCiAtR1VFU1RTPTA6bWFpbHRvOnBoaWxtZEBsaW5hcm8ub3JnDQpB
VFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1U
RU5UQVRJVkU7Q049ZWJsb3QNCiBAcml2b3NpbmMuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpl
YmxvdEByaXZvc2luYy5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1tYQ0KIHguY2hvdUBzaWZpdmUuY29t
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzptYXguY2hvdUBzaWZpdmUuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
Q049YWYNCiBhZXJiZXJAc3VzZS5kZTtYLU5VTS1HVUVTVFM9MDptYWlsdG86YWZhZXJiZXJAc3Vz
ZS5kZQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFS
VFNUQVQ9TkVFRFMtQUNUSU9OO0NOPUFuDQogdG9uIEpvaGFuc3NvbjtYLU5VTS1HVUVTVFM9MDpt
YWlsdG86YW5qb0ByZXYubmcNCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1iYg0KIGF1bWFuQHJlZGhhdC5jb207
WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmJiYXVtYW5AcmVkaGF0LmNvbQ0KQVRURU5ERUU7Q1VUWVBF
PUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NO
PUNoDQogYW8gUGVuZztYLU5VTS1HVUVTVFM9MDptYWlsdG86Y2hhby5wLnBlbmdAbGludXguaW50
ZWwuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQ
QVJUU1RBVD1BQ0NFUFRFRDtDTj1EYW1pZW4NCiAgSGVkZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRv
OmRoZWRkZUBrYWxyYXlpbmMuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049RWwNCiBlbmEgVWZpbXRzZXZh
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbQ0KQVRURU5E
RUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMt
QUNUSU9OO0NOPWVyDQogaWMuYXVnZXJAcmVkaGF0LmNvbTtYLU5VTS1HVUVTVFM9MDptYWlsdG86
ZXJpYy5hdWdlckByZWRoYXQuY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJF
US1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049amENCiBuLmtpc3prYUB3ZWIu
ZGU7WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmphbi5raXN6a2FAd2ViLmRlDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
Q049amoNCiBoZXJuZUBsaW51eC52bmV0LmlibS5jb207WC1OVU0tR1VFU1RTPTA6bWFpbHRvOmpq
aGVybmVAbGludXgudm5ldC5pYm0uY29tDQpBVFRFTkRFRTtDVVRZUEU9SU5ESVZJRFVBTDtST0xF
PVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047Q049Sm8NCiBhbyBNYXJ0aW5z
O1gtTlVNLUdVRVNUUz0wOm1haWx0bzpqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQpBVFRFTkRF
RTtDVVRZUEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047Q049THUNCiBjIE1pY2hlbDtYLU5VTS1HVUVTVFM9MDptYWlsdG86bHVjQGxtaWNoZWwu
ZnINCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtDTj1taQ0KIG11QGxpbnV4LnZuZXQuaWJtLmNvbTtYLU5VTS1HVUVT
VFM9MDptYWlsdG86bWltdUBsaW51eC52bmV0LmlibS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJ
VklEVUFMO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj1TaA0K
IGFtZWVyYWxpIEtvbG90aHVtIFRob2RpO1gtTlVNLUdVRVNUUz0wOm1haWx0bzpzaGFtZWVyYWxp
LmtvbG90aHVtLnRob2RpQGh1YQ0KIHdlaS5jb20NCkFUVEVOREVFO0NVVFlQRT1JTkRJVklEVUFM
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtDTj16Lg0KIGh1b0Ax
MzkuY29tO1gtTlVNLUdVRVNUUz0wOm1haWx0bzp6Lmh1b0AxMzkuY29tDQpBVFRFTkRFRTtDVVRZ
UEU9SU5ESVZJRFVBTDtST0xFPVJFUS1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1BQ1RJT047
Q049TEkNCiBVIFpoaXdlaTtYLU5VTS1HVUVTVFM9MDptYWlsdG86emhpd2VpX2xpdUBsaW51eC5h
bGliYWJhLmNvbQ0KQVRURU5ERUU7Q1VUWVBFPUlORElWSURVQUw7Uk9MRT1SRVEtUEFSVElDSVBB
TlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO0NOPXFlDQogbXUtZGV2ZWxAbm9uZ251Lm9yZztYLU5V
TS1HVUVTVFM9MDptYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnDQpSRUNVUlJFTkNFLUlEO1Ra
SUQ9QW1lcmljYS9OZXdfWW9yazoyMDI0MDUxNFQwOTAwMDANCkNSRUFURUQ6MjAyMzAyMjFUMTUz
OTUwWg0KREVTQ1JJUFRJT046SWYgeW91IG5lZWQgY2FsbCBkZXRhaWxzXCwgcGxlYXNlIGNvbnRh
Y3QgbWU6IDxhIGhyZWY9Im1haWx0bzpxDQogdWludGVsYUByZWRoYXQuY29tIj5hbGV4LmJlbm5l
ZUBsaW5hcm8ub3JnPC9hPg0KTEFTVC1NT0RJRklFRDoyMDI0MDUwOFQxMTA2MDNaDQpMT0NBVElP
TjpodHRwczovL21lZXQuaml0LnNpL2t2bWNhbGxtZWV0aW5nDQpTRVFVRU5DRToxDQpTVEFUVVM6
Q0FOQ0VMTEVEDQpTVU1NQVJZOlFFTVUvS1ZNIGRldmVsb3BlcnMgY29uZmVyZW5jZSBjYWxsDQpU
UkFOU1A6T1BBUVVFDQpBVFRBQ0g7RklMRU5BTUU9Tm90ZXMg4oCTIFFFTVUvS1ZNIGRldmVsb3Bl
cnMgY29uZmVyZW5jZSBjYWxsO0ZNVFRZUEU9YXBwbGljYQ0KIHRpb24vdm5kLmdvb2dsZS1hcHBz
LmRvY3VtZW50Omh0dHBzOi8vZG9jcy5nb29nbGUuY29tL2RvY3VtZW50L2QvMS1MdHExMUxMeg0K
IHhDY2NmcWZOTktjTUc3NEhNVUpmNkRVUm1TSkJHUVpyZWsvZWRpdA0KQkVHSU46VkFMQVJNDQpB
Q1RJT046RU1BSUwNCkRFU0NSSVBUSU9OOlRoaXMgaXMgYW4gZXZlbnQgcmVtaW5kZXINClNVTU1B
Ulk6QWxhcm0gbm90aWZpY2F0aW9uDQpBVFRFTkRFRTptYWlsdG86cWVtdS1kZXZlbEBub25nbnUu
b3JnDQpUUklHR0VSOi1QMkQNCkVORDpWQUxBUk0NCkVORDpWRVZFTlQNCkVORDpWQ0FMRU5EQVIN
Cg==
--00000000000008cffd0617ef4a95--

