Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED85C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tppwj-00059k-Kk; Wed, 05 Mar 2025 09:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tppwe-00059O-3y
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:42:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tppwZ-0001Hy-Ne
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:41:59 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525BFbOT031419
 for <qemu-devel@nongnu.org>; Wed, 5 Mar 2025 14:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KMAvoHIBOmlRXaQT/fpLNnZH
 bjlzeKVX+gWoNmJFO1Y=; b=b8LB9Ig890ioakWF73theuNvVYue13ZLH+mSdwlh
 47kRAY+P7XoXkYRYFac32gRk8D0xxknWqPh+SvMiQ6Vv/Y2cbn/eu1lGOsXHat/q
 nrLl2uvFAV2db78m92yC+IemnCDjBYQIBSnPaFFBRNieDASCd6C69bTTOpSV1iGy
 hJAtabw18cHh02irUHxwbbJ+3PDmHnZGyNHNFcSlBm5VdtHnQlbaIcKRoml7vtIn
 s07WPeW7+aZQo60MP6sqkIvd8/N+sYAIn9QH+JkDhc+fNFBeFCb6g8rpydguulgI
 m13Kf+3JIgXylK4XBa5T5jjjgfWGld+U2hG5WN6nnymgSQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t5muq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 14:41:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c3b5004351so725604285a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 06:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741185712; x=1741790512;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KMAvoHIBOmlRXaQT/fpLNnZHbjlzeKVX+gWoNmJFO1Y=;
 b=V6HZDZRGWlSIVQKjGVyPNvcLHkeonPl2D1OTxtB0r0n1kogiw3QFGzip3iTiKEEqBX
 Xt8oaeC+dtlndl4uKCE2IaycqufhA9b7d4GJvztoP7/1VHqr1q3O1KSzqpOrOVSFyO3l
 5gljRdtqZW7QPDgTIxsZNWbd5FkIOwuH6vjTXItVA035s2rUhnoQARaVXL+adKafKFJr
 2m++YGH+DLL+uklYxc4MDarAgeH4BhVTOeRE202a896+CeMF7pTkOYY7FaGzme8qLu92
 1T/X6teigjsFqBeecu61E6SGDu5uYN3r6kBxYwA9Tq8Vxgi5HeI+U8gLPNBkkDcoOH+O
 6YVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/cmp+8xMMZrH4ftX1ZThM/aS+GfMnDPd24GyBZeWY6PjneFjLg9UmYiaQxhrUFcuWAfJ9a8uxacRk@nongnu.org
X-Gm-Message-State: AOJu0YyOfH93+Kw6vie7ckIiDlSZ2isTfByxZoQfNd2kzLswxwRhPoy5
 kGSLkxsajrDHb9gqgP6VZ5h15DcAc9J+JqeLhrIofMaxD7EuDaRFxtFT4yBARt11FXe0WyIkMIn
 zPqZ8s3lFWnFuAASnIs6K9OiBWZhpJLl7UjYCOyXloz8z6i0QGDzOYYkJFCrvew==
X-Gm-Gg: ASbGncsoHwXRj2H7gCa4cLI5Va7auj3rLHbqqml7Pro4q1t0xeU3BmQtAdSofaMNvyk
 qYtuiAtZRrdjnR5lR87gXZ2dnT3UFXHzxjO7dHSx4s5dPfW7KsTBDlJOcns3LZWFGNg3h7zZSbg
 kigjx00sIB8q8bAN7IBbZtbWRdU7N3+OKQc2bwxHhV2mrf4PRj8zzlaVJFXoQT8pKtVfRLZNxSy
 8LR65LN1XVqV5qDNNH/TFunMfW/Fr4qjhKlLqpj2+7k/VIt+AaXOwO1WSaifHGB5Yy2QMjF4kv3
 Iz0o9kghVtSGkQx+VzfSaaFfSvZWVnH9nHY+yyYq9jKmJ40H97Y1Nex52Hg08IiWXOIaZ39LAWf
 X0CoL68s4WSGZStvC
X-Received: by 2002:a05:620a:8908:b0:7c3:bbe2:d71 with SMTP id
 af79cd13be357-7c3d8e76a5dmr545838585a.30.1741185711934; 
 Wed, 05 Mar 2025 06:41:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAxs2b4A9BTjKW+6bS01xHogc72wqZHx3eR/MDQAVbsJ/WGeF/h6PKji6L83zBGHR7RVks/w==
X-Received: by 2002:a05:620a:8908:b0:7c3:bbe2:d71 with SMTP id
 af79cd13be357-7c3d8e76a5dmr545831985a.30.1741185711257; 
 Wed, 05 Mar 2025 06:41:51 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3d657a95fsm157983385a.17.2025.03.05.06.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 06:41:50 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------4w2Voo1PUsL1bU40EXYhljar"
Message-ID: <aeaafcf9-c08a-4b27-878b-835f5bac3b2a@oss.qualcomm.com>
Date: Wed, 5 Mar 2025 08:41:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU and ia64
To: Benjamin Charlton <Benjamin.Charlton@avanti.space>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <CWXP265MB56711557D89741FDF97E192592CB2@CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CWXP265MB56711557D89741FDF97E192592CB2@CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM>
X-Proofpoint-GUID: nhD7sFqi1SMmg00iEhUlj5FfUBk7EyhZ
X-Authority-Analysis: v=2.4 cv=KfMosRYD c=1 sm=1 tr=0 ts=67c862b1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=Vs1iUdzkB0EA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=NEAV23lmAAAA:8 a=omcwqQGmAAAA:8
 a=wEBkMZjLN_1AjunG5HEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=EUspDBNiAAAA:8 a=jThZ7_-JAAAA:8
 a=UqCG9HQmAAAA:8 a=XTZRodZldfLsc-DOtZIA:9 a=p8g02hCxyafuhFUa:21
 a=UiCQ7L4-1S4A:10 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=ABxLrL2kQceUrnkV1OQA:9 a=HXjIzolwW10A:10 a=T6a71-JsGAwA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=iQ-hdiIwjq9GaLCbUU8Z:22
X-Proofpoint-ORIG-GUID: nhD7sFqi1SMmg00iEhUlj5FfUBk7EyhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050115
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------4w2Voo1PUsL1bU40EXYhljar
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/5/2025 2:37 AM, Benjamin Charlton wrote:
>
> Hello.
>
> Sorry to bother you, I am very new to all of this and but I am looking 
> for a ia64 emulator, sadly it has to be this to run a piece of old 
> software. GPT suggested I clone your project and emulate this 
> processor. However I am receiving an error
>

This is the Itanium architecture?  I don't know if QEMU ever supported it.


https://github.com/trofi/ski - here's an open source instruction set 
simulator for IA64 - maybe this will suit your needs.


> bcharlton@UK4072:~/Emulation/qemu$ ./configure --target-list=ia64-softmmu
>
> Using './build' as the directory for build output
>
> python determined to be '/usr/bin/python3'
>
> python version: Python 3.10.12
>
> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
>
> mkvenv: checking for meson>=1.5.0
>
> mkvenv: checking for pycotap>=1.1.0
>
> mkvenv: installing meson==1.5.0, pycotap==1.3.1
>
> mkvenv: checking for sphinx>=3.4.3
>
> mkvenv: checking for sphinx_rtd_theme>=0.5
>
> 'sphinx_rtd_theme==1.1.1' not found:
>
> • Python package 'sphinx_rtd_theme' was not found nor installed.
>
> • mkvenv was configured to operate offline and did not check PyPI.
>
> Sphinx not found/usable, disabling docs.
>
> ERROR: Unknown target name 'ia64-softmmu'
>
> Are you able to help?
>
> Thank you
>
> Best regards,
>
> Be More.
>
> 	
>
> *Benjamin Charlton*
> Ground Control Systems Engineer
> *Avanti Communications*
> Goonhilly Satellite Earth Station, Goonhilly Downs, Goonhilly, 
> Helston, Cornwall, TR12 6LQ
> t:+442077491600
> w:www.avanti.space <http://www.avanti.space/>
>
>
>
> <https://www.avanti.space>
>
>
>
> DISCLAIMER: This email including any attachments is intended only for 
> the person(s) ("the intended recipient(s)") to whom it is addressed 
> and it may contain confidential or privileged information. The 
> contents of this email must not be disclosed to anyone else. If you 
> are not the intended recipient please notify the sender immediately. 
> Avanti Hylas 2 Limited (“the Company”), any subsidiary or holding 
> company of the Company or any of its or their subsidiaries (each a 
> “Group Member”) will not be liable for any error in transmission. You 
> should carry out your own virus checks before opening any attachments. 
> Opinions, conclusions and other information that do not relate to the 
> official business of the Company or any Group Member are neither given 
> nor endorsed by it/them. Registered in England No. 7072502 Registered 
> Office: One Ariel Way, White City, London W12 7SL, United Kingdom 
--------------4w2Voo1PUsL1bU40EXYhljar
Content-Type: multipart/related;
 boundary="------------gDwpq5gXB53SSzj03Z1g60HH"

--------------gDwpq5gXB53SSzj03Z1g60HH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/5/2025 2:37 AM, Benjamin Charlton
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CWXP265MB56711557D89741FDF97E192592CB2@CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator"
        content="Microsoft Word 15 (filtered medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">Hello.<br>
          <br>
          Sorry to bother you, I am very new to all of this and but I am
          looking for a ia64 emulator, sadly it has to be this to run a
          piece of old software. GPT suggested I clone your project and
          emulate this processor. However I am receiving an error
          <br>
          <br>
        </p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>This is the Itanium architecture?  I don't know if QEMU ever
      supported it.</p>
    <p><br>
    </p>
    <p><a class="moz-txt-link-freetext" href="https://github.com/trofi/ski">https://github.com/trofi/ski</a> - here's an open source instruction
      set simulator for IA64 - maybe this will suit your needs.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CWXP265MB56711557D89741FDF97E192592CB2@CWXP265MB5671.GBRP265.PROD.OUTLOOK.COM">
      <div class="WordSection1">
        <p class="MsoNormal">
          bcharlton@UK4072:~/Emulation/qemu$ ./configure
          --target-list=ia64-softmmu<o:p></o:p></p>
        <p class="MsoNormal">Using './build' as the directory for build
          output<o:p></o:p></p>
        <p class="MsoNormal">python determined to be '/usr/bin/python3'<o:p></o:p></p>
        <p class="MsoNormal">python version: Python 3.10.12<o:p></o:p></p>
        <p class="MsoNormal">mkvenv: Creating non-isolated virtual
          environment at 'pyvenv'<o:p></o:p></p>
        <p class="MsoNormal">mkvenv: checking for meson&gt;=1.5.0<o:p></o:p></p>
        <p class="MsoNormal">mkvenv: checking for pycotap&gt;=1.1.0<o:p></o:p></p>
        <p class="MsoNormal">mkvenv: installing meson==1.5.0,
          pycotap==1.3.1<o:p></o:p></p>
        <p class="MsoNormal">mkvenv: checking for sphinx&gt;=3.4.3<o:p></o:p></p>
        <p class="MsoNormal">mkvenv: checking for
          sphinx_rtd_theme&gt;=0.5<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">'sphinx_rtd_theme==1.1.1' not found:<o:p></o:p></p>
        <p class="MsoNormal">• Python package 'sphinx_rtd_theme' was not
          found nor installed.<o:p></o:p></p>
        <p class="MsoNormal">• mkvenv was configured to operate offline
          and did not check PyPI.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Sphinx not found/usable, disabling docs.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">ERROR: Unknown target name 'ia64-softmmu'<br>
          <br>
          Are you able to help?<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Thank you<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Best regards,<span
            style="font-size:11.0pt;mso-ligatures:none"><o:p></o:p></span></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-GB"><o:p> </o:p></span></p>
        <table class="MsoNormalTable" border="0" cellpadding="0">
          <tbody>
            <tr>
              <td style="padding:.75pt .75pt .75pt .75pt">
                <p class="MsoNormal"><span
                    style="mso-fareast-language:EN-GB"><img width="80"
                      height="80" style="width:.8333in;height:.8333in"
                      id="Picture_x0020_11"
                      src="cid:part1.Uo9mUFtR.80LsqF5E@oss.qualcomm.com"
                      class=""><o:p></o:p></span></p>
                <p class="MsoNormal" align="center"
                  style="text-align:center"><span
                    style="color:#4AC4B5;mso-fareast-language:EN-GB">Be
                    More.</span><span style="mso-fareast-language:EN-GB"><o:p></o:p></span></p>
              </td>
              <td style="padding:.75pt .75pt .75pt .75pt">
                <p class="MsoNormal"><b><span
                      style="color:gray;mso-fareast-language:EN-GB">Benjamin
                      Charlton</span></b><span
                    style="mso-fareast-language:EN-GB"><br>
                    <span style="color:#4AC4B5">Ground Control Systems Engineer</span><br>
                    <b><span style="color:gray">Avanti Communications</span></b><br>
                    <span style="color:gray">Goonhilly Satellite Earth
                      Station, Goonhilly Downs, Goonhilly, Helston,
                      Cornwall, TR12 6LQ</span><br>
                    <span style="color:#4AC4B5">t:</span><span
                      style="color:gray"> +442077491600</span><span
                      style="color:#4AC4B5"><br>
                      w:</span><span style="color:gray"> <a
                        href="http://www.avanti.space/"
                        moz-do-not-send="true"><span
                          style="color:#0563C1">www.avanti.space</span></a></span><o:p></o:p></span></p>
              </td>
            </tr>
          </tbody>
        </table>
        <p class="MsoNormal"><span
style="font-size:11.0pt;mso-ligatures:none;mso-fareast-language:EN-GB"><o:p> </o:p></span></p>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
      <br>
      <br>
      <table border="0" cellspacing="0" cellpadding="0">
        <tbody>
          <tr>
            <td><a href="https://www.avanti.space"
                moz-do-not-send="true"><img border="0"
src="https://eu-api.mimecast.com/s/store/8tiInYxF340R6JeVLWUTdpmCh441t-hlPzFwDArFFMEOVhst0cFFOumhi_4e_kI2pZtyA0bTWpmB0jcfK820H6RtaCm5BjcFcGscsTZHotvVi-9NqQbhIKfhy8n0FciGysn5mCYJZkfoTze2RGCzrr8hgYDuECFDg0r2EoSnyoqy_YbcNejDFyHZK_DKqCdG"
                  moz-do-not-send="true"></a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      DISCLAIMER: This email including any attachments is intended only
      for the person(s) ("the intended recipient(s)") to whom it is
      addressed and it may contain confidential or privileged
      information. The contents of this email must not be disclosed to
      anyone else. If you are not the intended recipient please notify
      the sender immediately. Avanti Hylas 2 Limited (“the Company”),
      any subsidiary or holding company of the Company or any of its or
      their subsidiaries (each a “Group Member”) will not be liable for
      any error in transmission. You should carry out your own virus
      checks before opening any attachments. Opinions, conclusions and
      other information that do not relate to the official business of
      the Company or any Group Member are neither given nor endorsed by
      it/them. Registered in England No. 7072502 Registered Office: One
      Ariel Way, White City, London W12 7SL, United Kingdom
    </blockquote>
  </body>
</html>
--------------gDwpq5gXB53SSzj03Z1g60HH
Content-Type: image/png; name="image001.png"
Content-Disposition: inline; filename="image001.png"
Content-Id: <part1.Uo9mUFtR.80LsqF5E@oss.qualcomm.com>
Content-Transfer-Encoding: base64

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
XYfu4NftvCwdmenZSchESuql6XyabUoLkSjoNTUVNCAmAy3vS2JTIl9hUsHHFBHdK2hk4XZQ
6+21aRZYAANn0xNhExjZ6pSTjzoYjodoo6ZQkHs/XnNBszSL1n0eQyTVwYNnfAiwweF3dGjC
vMztwT5PPX56sEe3LFuilTeTKEVHZNfEEKXV78DzpzP4edTSPK3BizjhPjPpl56ZnM+zjxtY
1VcHgerdHuR3P2rHhAN11uM9Dm6iexkC6uvTggQ+/3waESSmR2DUTAiV88tFZ9RjMiGBK/eZ
zmp2ePDvpz6OtvA0j6h//p5nBtSuuhHESLOTIkoQEd8PHhSxVgORo475rgchCwkEx2XraOdy
5zLcM2cFF/sxsQ1qX80Gimp0/M5sT6O54nyHxpyyGjHYlq8paNZkePuiaf/TSXbNHJj/A8pP
Co0rDrdJAAABhWlDQ1BJQ0MgcHJvZmlsZQAAeJx9kT1Iw0AYht+mlopUHOwg4pChOlkQK8VR
qlgEC6Wt0KqDyaV/0KQhSXFxFFwLDv4sVh1cnHV1cBUEwR8QRycnRRcp8buk0CLGO457eO97
X+6+A4RWjalm3xSgapaRSSbEfGFVDL4igBDNOGISM/VUdjEHz/F1Dx/f76I8y7vuzzGoFE0G
+ETiOaYbFvEGcXzT0jnvE4dZRVKIz4knDbog8SPXZZffOJcdFnhm2Mhl5onDxGK5h+UeZhVD
JZ4hjiiqRvlC3mWF8xZntdZgnXvyF4aK2kqW67TGkMQSUkhDhIwGqqjBQpR2jRQTGTpPePhH
HX+aXDK5qmDkWEAdKiTHD/4Hv3trlmLTblIoAQRebPtjHAjuAu2mbX8f23b7BPA/A1da119v
AbOfpDe7WuQIGNoGLq67mrwHXO4AI0+6ZEiO5KcllErA+xl9UwEYvgUG1ty+dc5x+gDkqFfL
N8DBITBRpux1j3f39/bt35pO/34A3bhy0piWEDEAAA0YaVRYdFhNTDpjb20uYWRvYmUueG1w
AAAAAAA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5
ZCI/Pgo8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJYTVAg
Q29yZSA0LjQuMC1FeGl2MiI+CiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMu
b3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogIDxyZGY6RGVzY3JpcHRpb24gcmRm
OmFib3V0PSIiCiAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4w
L21tLyIKICAgIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5
cGUvUmVzb3VyY2VFdmVudCMiCiAgICB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2Vs
ZW1lbnRzLzEuMS8iCiAgICB4bWxuczpHSU1QPSJodHRwOi8vd3d3LmdpbXAub3JnL3htcC8i
CiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHht
bG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgeG1wTU06RG9jdW1l
bnRJRD0iZ2ltcDpkb2NpZDpnaW1wOmVhZDhlMzhmLTcwMDEtNGQxZS05MTNhLThkNTQ3Mjgx
NWZlOCIKICAgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozMzk4ZDA3Mi1kMmMyLTQzNDQt
OGMzYy1mYmMyZWFhNWQ0MjUiCiAgIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRp
ZDoyMGUzNWU2Ni0wMzRjLTQwOWUtOWE1OS05NmU2OWIwZmVhNTciCiAgIGRjOkZvcm1hdD0i
aW1hZ2UvcG5nIgogICBHSU1QOkFQST0iMi4wIgogICBHSU1QOlBsYXRmb3JtPSJXaW5kb3dz
IgogICBHSU1QOlRpbWVTdGFtcD0iMTY1MjM2MDEyMzE0MzE2MSIKICAgR0lNUDpWZXJzaW9u
PSIyLjEwLjMwIgogICB0aWZmOk9yaWVudGF0aW9uPSIxIgogICB4bXA6Q3JlYXRvclRvb2w9
IkdJTVAgMi4xMCI+CiAgIDx4bXBNTTpIaXN0b3J5PgogICAgPHJkZjpTZXE+CiAgICAgPHJk
ZjpsaQogICAgICBzdEV2dDphY3Rpb249InNhdmVkIgogICAgICBzdEV2dDpjaGFuZ2VkPSIv
IgogICAgICBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjJmNGFhNDY2LTk0OWMtNGVhZi1i
NDU0LWVhODVhZGYwYjQ2NSIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iR2ltcCAyLjEw
IChXaW5kb3dzKSIKICAgICAgc3RFdnQ6d2hlbj0iMjAyMi0wNS0xMlQxMzo1NToyMyIvPgog
ICAgPC9yZGY6U2VxPgogICA8L3htcE1NOkhpc3Rvcnk+CiAgPC9yZGY6RGVzY3JpcHRpb24+
CiA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCjw/eHBhY2tldCBlbmQ9InciPz43VyerAAAABmJLR0QA
AAAAAAD5Q7t/AAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH5gUMDDcXlDG+YAAACVhJ
REFUeNrtnH+wVVUVxz/3Pn7IM/xBEiiYCEaklaGoKFvMVxnuTfgywvgVkYBDQgIpWagpo5NT
wDD8kIGxMEQQpAR178cgMRNsi4lmooxSEV5C0g8pjV8DAu/2x1ln7ul6z+Wex7u8X3fN3Dl3
73POPnt/z9pnrb3W2gvKVKbGpFRT6oz29lygD/AJoAvQHTgr0s8MUAf8G9gL7AF2OmXeaJUA
am+7A4OAm4H+QM96NnUY2AZsATalYItV5mSLBFB7exEwGrgD6Btz2THgDeAA8A/giHBfW+B8
oDPQDegac/+7wDpgeTqV2vTSAJ1p9gBqbwcCU4EhQDpy6iiwGXhFuOhVp8zfimyzPfBJeRE3
CCf3yLlsN7AAeNIpc7DZAai9rQIeBa6PVB8E1gKrgY1OmaMN+LyPA18BRgBXRE69B8wG5jpl
DjV5ALW3vYG5wK2R6j8B84EVDTmIAn24Drgb+JpMf4B/Afc7ZZY2SQC1t22A+4EHgPZS/Qfg
YafM2kYSVhcD3wfGAW2kejMwzimzs8kAqL3tCawC+kXe9vfSqdTSUn7IE07v2YCRqiPANKfM
4kYHUHs7BFgOdJSqp4ApTpn/NjXlV3s7FHhCpDnACmC8U+ZIowCovZ0OPC7tvQd80ynzfFNe
QWhvuwI/A26Rqt8Btzll9p1RALW3C+RDDfBHoNopU9sclmGDX3GpukzmEeBBqfor8DmnzO4z
AqD2djEwQYobgNudMoeb23pWezsS+CnQDngbuMkps6ukAGpv5wGTpbgSGOOUOd5cjQLa288D
LwAdZJ09wCmztyQAam+niTQDWJWCEVaZuuZuWRGl/yUB8S9Af6fMgQYFUHt7K2Dl3o2Accq8
31LMU9rbauAXMr71KTCFmCOdsPFLROSngD/LN6/FgAcgyv40KQ7KwEMNwoHG23Qm0N4HyFr2
KqfMm7RQ0t4+I+vpOuCzTpktp8WBGZgi4AFMaMnghWME3hSMntLeVtYbQO1tF2BmKDScMs+2
cPAQdWy0cGBP4Aenw4GHgOOyyphMKyGnzFYCWyLAVO3tZfUCUN7GUrGovEProgeBdwjMYT88
HSk8RxbgrYpED3xYikO1t1eWxBrTkkl72xbYBVwMrHTKjKiXHthaSZaos6T4VXGMlQFMSEtF
/20D3FkGMDkXHgRC9e0bZQDrR8vl2FN7e1UZwIRUkUptIXD0A1SXAUxILwaOsR5AJYGvu0xl
amTKq0gbbysyQbzJq06ZY2dQYe0FHHXKvN1cAGyTrzIThEIsJ/Dk/6TAgIcD35bisHw+BO3t
gIgSOj3Orqa97QBsBWqBaxOA/jTwllPmgZjzLwMfAh53yqzLc342QWBSPtrtlBmZ555FwHXA
ujgh8p3QAnGK/m8CriaI7ZsYc809cr6HABRHXwcuAK7R3t6YgAk+DczQ3t4dc76fPL9LzPk+
cj7f78oCz+0L3JzOg24V2bi9K7S3uoBy+U9gjRTHaW/b5bTVDbhdiovjvHbG2zRwb54XmITm
aW+/VI/7aoAlBJFiIa2Xuudi7tkjx075OPC7MdwYR6G9rDMwLOfct4AKAlviorgGMnAbELW1
DdHefiwhEGngWe3ttUlucsoscMrcFbG4AMx3ytzllHkk5rbQpNcjncMxnyIb6hDGHVdpb/sW
6MCvge0RwMK22gPjpbhauDWO7ou82aMi3KbWg5sqgbXi/ColhYK1MpcDw2l0mCB2+UCR38KF
crxee/sZ+X8H2eCdBQWEwA1kgy9nAcvk/xjt7YcTDGo78D5wIbBee3teCQEMA6Yq0pGBXAQM
Dy0PEt8SSuDhURNOHlpBEJcM2TiZSXLcJqbxOApf2rti8ZgT4aaJCQa1NcLxfYQT25dajYly
4FQCs3VdZBBzgBOi7txTYBofkcEDjNDe3gJcE35PCnBf73BNCSx0yhxyyrwOvCh1k5OA4JRZ
RhDYCXAT8GSJcDtXjifTMpBzIm/vBLBJe1tLsG0g9MpP0N52LNDoE4E8oJIgVib82K4ucM+0
iDI/TntbK88N3acfAUYlFAqPRYAbBZRiKocv9VDIgeMiqLYTnS38harJecDYAh3fJeIfoFNE
dTkWw32dRfcLqWvkmZ1yQE5KEwmixUpFF4RCLy0xzaGQ2CFTLve3IxyM8baiCJUm5ORFBa6d
RBDEkxEhlPvMVXLd5RKPk4QLT4j++fsSARhK+f1tRHB0D9UJp0xNHm75grzRSzIwNDK4//+g
plI1dZlMLXAp8PO4aE/x8ofC5gWnzKR8ynUmWEX0El20JiGIh7W3g4HfAB9tYAB7y3FnWqZI
RgwHNTGdeVneZqbQlJJA8oWnEh7AGJmmGeBH+S6QiKhZck1Vrjvxg7p43n7vA7SoY8UEuWeK
vO64qE2bS2FRqUy6GihTmcpUXypHJiQkE2gtACetMpmyUynZ931gBo7Lr1/uUq5Mp6ZwVVTr
lNlWBjAZ93UkcHVAsMOJMoDJaCzBPsCTUSNFGcDiuK8tWbPb6qjXMJ2gkUtzfR6tiMYTxAaS
u3JKwoH3knVhtibuO4esv2SNU2Z7YgClkdHAQ9rbC1sZhjMJXBPHgRkfMKAU2cjZonR3pBXF
SWtv+5PdlTA3X4KfYqP0/07WVF6tvR3bCsA7G3haMNoN5HVxFv0NrEil5gG/kuJ87e3lLRzD
JQS+6jpgbNw+6KIBlNi4UcB+mdLrtLfnt1Dum0KwTw7gUadMrN0vkR4oGYWGizJ5GYHr8KwW
Bl41Wa/khlTM1K23Iu2U2UjWxTkQeE4UzZYAXhXZ7byvAcNOtZG8XisRp8xC4MdSHAysae6c
KFv+w93qe4EvFpOypd5LOafM9IhKMwSokfx/zRG8kQS78DsA+wgyd+wp5t6GSHsyi2wE1+vA
kMZMiJiE8qQ9eQuoOmNpTyIgTiZINJYm2M0zoanvKZY90Mto7MQ7kQ4NIgjpCEMpVgGTnDL7
myB4uamfVhIkImuc1E+RjoVJKcKY4/8AM1KwpCmkRWnSycdCkoiC+wi2yHeQ6h3ATKfM6kYC
Ll/6uy3AnU0q/V1Op3sRRBZUR6pfA+YBy0uRjjNPH5pfAsY8g7gReAyIRt4fBp4nCOLeUE4B
WtzABhCkTvkyQeB5SMfIJqH9LeUktKccdFeyaZCvjrmsodIgP5NOpX7ZItIgx4DZjSCYvYpy
Iu4GAbTZpYIvU5kal/4Hh6dLVbDnOvgAAAAASUVORK5CYII=

--------------gDwpq5gXB53SSzj03Z1g60HH--

--------------4w2Voo1PUsL1bU40EXYhljar--

