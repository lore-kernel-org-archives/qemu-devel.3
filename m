Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CABC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKSQ-0002eA-M9; Tue, 18 Aug 2026 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wwKSO-0002e1-Sy
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:06:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wwKSN-0006Pq-3f
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:06:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE0Vct2564087
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 14:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sRKLnJ+RSVW
 /gicVw9eBheaNQx9/112syQkv0QhN1rI=; b=aOPtnYl1N4j/Msi9eZdW6V530+a
 5c/oG+xeZLEyWAfYmUsBCxId1wFacJCiFAoap9IVf17LYw1cI4QUQOpQrpv3H0as
 /9fL22C3V01kFq/2gbOOl0qRGpBPYGGWhvdWXwByKYyF7mbJVCpg1FaOhZUV+iFJ
 y4lZg0SHy5YOQHI2j35vQNlbEEDvrh0eGNKXlAxCKFmjMzl7tCuOnxwkGjgCCp7e
 5MIfQM7Txx4qukeb1JIEgvphOxkB9rrNQ8MO7K/JCujHH8kO3cStN0cONTHzD0yK
 naaU/HIYaA+EtkEKznO2gxYj6Q/sE7PTbH+7PUCB88ZEH4OeNrPedvrCOaQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmtgnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 14:06:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfe48ca1efso64334085ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787061977; x=1787666777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sRKLnJ+RSVW/gicVw9eBheaNQx9/112syQkv0QhN1rI=;
 b=Zy8gsMHKpbfjU/rY/fgJ/LYl2Q+yiQS86L8qDyK/HMJo9nRaTXqJfep9BeUIqakui+
 p1Eq28pZKyAaNenEQ/kWHHEPzSuwzriBpuB1xSOWDmCrk4088cF0iwipencJCT9E3D2a
 tg8MuKvCStNuHAwb28tGjvAqIsSAfBD2y70JzYWdEvL1juMWrsjTDtwk4mdRLgByDfTj
 CsC4oYIqlzT+AnRBEyvCBLgFSYgpN92TYVmWlrLuEDALGrDkWDyrcE5fSAqyMlUVlzM2
 WfzYMwLOkwJ70ofj4KOC7CaOspsKvYZmdHwAsemu3lR+jrQQWKe0iVyXJ4F3MCUbO1As
 tyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787061977; x=1787666777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sRKLnJ+RSVW/gicVw9eBheaNQx9/112syQkv0QhN1rI=;
 b=Z33XUVAvPuQ0n2eXt6oVBDO3hhE48WpC3ccA29Wf95feIX9nUDaF2N6GTi+vStOlLi
 q7NJILSvpk5Ymi6hi4xGaEFkzl18UaIXeRas2gtcOqU4D5S8S1ZQM0dPJmXIs8DXSNLI
 4fxP7wewpryu5e8V1N6SQ/WT8e1IQdPgttA0VylmCy7bxRq953MpfxgsWHbH/chxnZrH
 kISm42dt90TSvl76Qg1uzXgzKTBD9Rj0rsflHCj0rMxV63iMnsApOi68zzfopLniSgm4
 zjUlmH1LULT/ZGF/4niN5g0n5TK/f7OwXePGI/MZS2nzknGkIzCIZ5QxXSmp+3r+Zuzc
 8atw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHo98WlHySRKiKORfoNOI/Gxl9KcIwA9gYMTymv6hq3Ctd5lbM9gEZ+xyKJFte/mU7NSpKB0Ih+ERq@nongnu.org
X-Gm-Message-State: AOJu0YyMTfPFE9Bi816d+saW1pkqJqopWjI50sjKq8f46oglw7kAl25T
 c4aZvGiQavCRkN1xCA2W0+eNq1UzyHtftOFIbwXAvEAlqCckBMOIFIuVW1Lu39Y8T7sxkmgdzcd
 +s/bQF4t4rpvTDwJ92FUG9ybq2CQIfiLeaToIa5grwFH/eY1q7k5Kw0Rc9w==
X-Gm-Gg: AR+sD115CcfC9/wqpguyGy6qT0Wa8bwn/Bde6Ikmk1JkQWTpxLcec5nFJa8YjSItTLw
 Y/00lkQLCK9iydH1nF/GdkpQ4woWxNLMLH3A1B9fg2MRzly2opxSj0Mcd3yD5i8SbmAkQUo5fsS
 3teHqW2cwh8jUXMyn+sGVhPDEqDXqXqA3+tUfNLbENZbAiGWVem6kR0pduh/LEaNNEUl8I9fpMz
 sS00dn5y/RiZqHamr4QKKD6lITi93KMcJg6oF5eHwz1YiutsF69jBY63QsfcLTfO8GiqAwQfmPr
 3unVIeqhC45QRHEukTRjcRcA4N5e6C03RR6A6TDGs3we4oVg9damTTangrVKJbrDLEbPlMF5eiO
 HRmelWFwmZc51aFWcjkAlAsRgwBY1XsA5ZMGrcHBXxBmyiV1mVIJXGkiNK+z6H4I=
X-Received: by 2002:a17:90b:39b0:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-3933b500d17mr34199379a91.0.1787061977187; 
 Tue, 18 Aug 2026 07:06:17 -0700 (PDT)
X-Received: by 2002:a17:90b:39b0:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-3933b500d17mr34199206a91.0.1787061976488; 
 Tue, 18 Aug 2026 07:06:16 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267be8e272sm16633573eec.17.2026.08.18.07.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:06:16 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: philmd@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 ktokunaga.mail@gmail.com, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 ale@rev.ng, anjo@rev.ng, alex.bennee@linaro.org
Subject: Re: [PATCH v3 09/13] target/hexagon: add main arch-specific
 semihosting operations
Date: Tue, 18 Aug 2026 07:06:14 -0700
Message-Id: <20260818140614.77952-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <709f1994-e992-45e8-b33f-1a00b943bc50@oss.qualcomm.com>
References: <709f1994-e992-45e8-b33f-1a00b943bc50@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMyBTYWx0ZWRfX9autLz46vyxh
 qIRBJ2Mlen+Q+wFB/EIsBhgpGVT/2xPpNM2UuKChwyMtwrSbGmQL5ijolX2xk5vUucQc3yQpgdh
 65sNjKJ50wjBImGXOhLRytcvFp/nHXW+b3BvHNHG9WwhWFRLpEk8V5hh+5udgVC75wsOmJJLnZI
 Jdpn2V8M2ye1sffz6sAg/HxExE8KV1dW7Xsp583g0bCLYgmaSZIRdNBvkO92NnO9LgvnXIB3d+2
 +/sFg4pF7UlD9ArBHWGjdU7vPSs+V+m7jkhZRPv7tbIIR0hmcfrwlCibno+9AEb+MSj1znI6DlU
 Ai3CPMv8KML/opt7L+Ux2T4381q8HUsIHaTCJCH6lldoK5vED8eCGvDDKFsbZeEVx5fo1p3XbqM
 0CTJOYqY9t+ctmcSiSjO/jeAfxzYlouPsiiY+UvAJEgoVfqh5dqYs6VE02i/yiYbs9OVVbwwMIH
 MgJ0N5e9F3tPbS+PsPA==
X-Proofpoint-GUID: zI9uSSPpoxnn0imxKPS9LFhFC0uqS4l2
X-Proofpoint-ORIG-GUID: zI9uSSPpoxnn0imxKPS9LFhFC0uqS4l2
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a8466da cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=uZvujYp8AAAA:8
 a=vQdOg9i1AAAA:20 a=EUspDBNiAAAA:8 a=mVr0gc_ur1I0NzJS-0UA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=SLzB8X_8jTLwj6mN0q5r:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMyBTYWx0ZWRfX0vqHf0Vtwzvb
 vCsYzjWW/5YaH1Qtn1FFxzL0ylAeasM66NNXJYr8ZAjWMwg+OPvzE0IUZaoMCibIPPFLGseKcjd
 TF9w7/X+LEyr0PZOJhurfNW4KE0hmiQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180103
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Mon, 17 Aug 2026 06:29:56 +0200 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com> wrote:
>
> On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> > 
> > +        if (rc = 0) {
> > +            sys_stat.dev   = st_buf.st_dev;
> > +            sys_stat.ino   = st_buf.st_ino;
> > +            sys_stat.mode  = st_buf.st_mode;
> > +            sys_stat.nlink = (uint32_t) st_buf.st_nlink;
> > +            sys_stat.rdev  = st_buf.st_rdev;
> > +            sys_stat.size  = (uint32_t) st_buf.st_size;
> > +#if defined(__linux__)
> > +            sys_stat.atime = (uint32_t) st_buf.st_atim.tv_sec;
> > +            sys_stat.mtime = (uint32_t) st_buf.st_mtim.tv_sec;
> > +            sys_stat.ctime = (uint32_t) st_buf.st_ctim.tv_sec;
> > +#elif defined(_WIN32)
> > +            sys_stat.atime = st_buf.st_atime;
> > +            sys_stat.mtime = st_buf.st_mtime;
> > +            sys_stat.ctime = st_buf.st_ctime;
> > +#endif
> 
> This #if/elif seems bogus in that various hosts are not covered,
> in particular *BSD and WASM. We could use #else #error to catch
> them, or better implement OS-specific [f]stat() helpers (see
> include/system/os-*.h).

Good point... Hmm, what if we used st_buf.st_[amc]time for all cases?

It is mandatory on POSIX 2018[1] and also provided by mingw-w64[2]. Would that
cover all our use cases? Or maybe not?

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_stat.h.html
[2]: https://github.com/mingw-w64/mingw-w64/blob/master/mingw-w64-headers/crt/_mingw_stat64.h#L38

